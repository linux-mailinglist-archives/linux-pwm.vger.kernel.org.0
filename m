Return-Path: <linux-pwm+bounces-5117-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86AA56189
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D547A8B63
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810511A316A;
	Fri,  7 Mar 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7thCYSY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51146176FB0;
	Fri,  7 Mar 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331271; cv=none; b=cdEc0dq39xeULdk7NehuIV9lAWUhzXMO6jb3ApFCjgU04hJiBb7zVgns8zbMBW79DD3vYPRDkdB7PClSayWwlzeYbNrcjA7UMrUUQHDGi74UU4LsdH04Mzaz/QPs4g+76Fycga3ZSyHB6qOTIfK/SV3cHf1PQiqaQXW234ZL+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331271; c=relaxed/simple;
	bh=D3+I8NtgZHk+c+g1uw4s/Sws2OMet4ZwPvmAAst1MOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZjCKheOri65+NyniZkNd86JEV4ZljNOvAIQV4xFytaVKfuLocwFIqEcNREYDhQqiw2U0mio7XkFqxTrfm9YKxn/PYa8X2SJCjLaqrlzVy6d5jgz01zTE9n0vwpfbpwHq9uFn4gQ37on1JhUhuuKn6aNOkqLUJXIKqvVBIKAuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7thCYSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D542EC4CED1;
	Fri,  7 Mar 2025 07:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331270;
	bh=D3+I8NtgZHk+c+g1uw4s/Sws2OMet4ZwPvmAAst1MOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B7thCYSY7nL82ijvKVo26E5THhX8AFCM9E0KW79xc8bzIViD4dcBKNVoav8+yS7bC
	 Nj0otdIV3HCn1IMMyuLbmTaLTsSTjZH+XRS6cR1XOBzqwMQbCr7X2oh2SFSAZZtVak
	 Ck0sNJzaOKv3IxLT8qOoqwyjRL/amijnrpsPdeq6XROWWmaTjG2aRqPcsP9a0Z/2o0
	 8WM17bHikPnxRHQLw7pdQA9OJ1tm0bmLgRGD15sDD337UzvsoWQVIi+MKSik6nweqs
	 T5i4RZ9ez8GJuiDD1XYEJCZ0Syw140+oy5o0SmU+7sJRUnCmeYCnKqt4N1FqH5QSAE
	 DRTAai1xyoeEg==
Message-ID: <2bcd2718-9ae5-4475-86a3-93fce973d047@kernel.org>
Date: Fri, 7 Mar 2025 08:07:42 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
 Kamal Wadhwa <quic_kamalw@quicinc.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <dbfb17df-90e2-4a7c-9921-9dff5e9382f4@kernel.org>
 <ovnmhbzwwimil3opuv6e2ayyntlx7upxfkzm5qdfskx2x7hl7x@wmtul33ttow5>
 <bdca9e9f-7e0d-4ca7-8e8b-f27ea8bb3b54@kernel.org>
 <fnxx2tduww5m3ljs3g5po23ucr4qfytzipgspcf2udkusg7ys6@semr224oy56d>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <fnxx2tduww5m3ljs3g5po23ucr4qfytzipgspcf2udkusg7ys6@semr224oy56d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2025 00:33, Uwe Kleine-König wrote:
> Hello Krzysztof,
> 
> On Tue, Mar 04, 2025 at 05:30:40PM +0100, Krzysztof Kozlowski wrote:
>> On 04/03/2025 17:03, Uwe Kleine-König wrote:
>>> On Tue, Mar 04, 2025 at 10:53:53AM +0100, Krzysztof Kozlowski wrote:
>>>> On 04/03/2025 07:24, Uwe Kleine-KÃ¶nig wrote:
>>>>>> [...]
>>>>>> ---
>>>>>> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
>>>>>
>>>>> My git repo doesn't know that commit. Given that you said your patch
>>>>> bases on that other series, this isn't surprising. Please use a publicly
>>>>> available commit as base parameter, otherwise you (and I) don't benefit
>>>>> from the armada of build bots because they just silently fail to test in
>>>>
>>>> As you can easily see in the signature, this patchset was generated by
>>>> b4 and such tag was added automatically. No point in stripping it even
>>>> if it is not useful (life, happens).
>>>
>>> My request was not about stripping it, but making it useful. I don't
>>> know the b4 patch sending side, but git send-email has the capability to
>>> make it more useful in this scenario. I didn't check, but
>>> `b4 --edit-deps` which Abel mentioned sounds about right.
>>>
>>> The relevant documentation for the git side is the paragraph "BASE TREE
>>> INFORMATION" in git-format-patch(1).
>>
>> Useful how? The dependency is on the lists, so there is no base-commit
>> you would know.
> 
> Have you tried to understand the part of the manpage I pointed out? It
> seems to me "base-commit" has different semantics for us and only mine
> is aligned to git's (and consequently b4's) meaning.
> The correct base commit would have been
> cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d.
> 
>> And regardless of edit-deps, that base-commit tag is standard from b4,
>> so what do you expect from all submitters even if this was not RFC?
> 
> I don't understand this question. I expect from submitters to pick a
> publicly known commit as base no matter if the series is an RFC or who's
> standard this is.
> 
>> Always base on known commit?
> 
> Yes please. The manpage isn't explicit about that but the above
> referenced commit has:
> 
>     The base tree info consists of the "base commit", which is a well-known
>     commit that is part of the stable part of the project history everybody
>     else works off of, and zero or more "prerequisite patches", which are
>     well-known patches in flight that is not yet part of the "base commit"
>     that need to be applied on top of "base commit" in topological order
>     before the patches can be applied.
> 
>> But for most of the cases this is
>> irrelevant. I can have intermediate commit between linux-next tip and my
>> patch, thus base-commit will be bogus for you, but it does not matter
>> for the patch - it's based on linux-next.
> 
> I agree, linux-next is the base. So the respective tip of linux-next is
> the right thing to pass to git format-patch --base (independent of if
> it's called directly or through b4). Ideally you also drop the
> irrelevant intermediate patches to make the build bots test exactly the
> changes you suggest with your series. I would expect that this is the
> tree you actually tested, so it shouldn't be a big hurdle.
> 
> So summarizing we have: Iff you use --base with a non-public commit, it's

Which is easily visible that it was not the case here. No human used
format-patch thus no human used --base.

> useless and irrelevant. I fully agree. Our conclusion is different
> though. You accept it's useless (and even request from me that I do the
> same), and I asked the submitter to use --base as intended to make the
> resulting information usable.

Because you expect additional steps for users of b4 and pointing in
review standard use of b4 is extremely nitpicking.

Best regards,
Krzysztof

