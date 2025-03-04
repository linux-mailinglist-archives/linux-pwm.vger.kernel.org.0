Return-Path: <linux-pwm+bounces-5077-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705FA4E705
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 17:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D25E7A30A1
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCCC2BE7DE;
	Tue,  4 Mar 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXs8xEwP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E229B204;
	Tue,  4 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105849; cv=none; b=I6x2QuHKxU4SCAJuhcXEKesOeJ2jZCBApMCujGjmnUhGuKdLRyeaVytnck1ZzqI+PXd6Wm4wSKkf1QWW+EuLrl3P5j+jviJ+QE/KKFo5cYZRn0IKE23y/oNY5p+CRtoMIxXWGg24MlxD39FMGIMWnFJZwCKEtDAdSKJMAkf+p4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105849; c=relaxed/simple;
	bh=7SSmhJywGvGXc8ZpfXpgY0nfMFXwgP1l6sL+dAYzJYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpHvQohRkggWMY+7Izmpwc7VByFy5s3nVXUQJesDaUgi2xq53eQ092oFxonyIwXdYl49YEXOAnxrobzFQabbINdcRREEFWZ+vDDjRdZLxaOi5pt/Z5VX/U0brmeBvEf11mlpN3D1jypoKckBycuArdWvec25L9+9XS/eiw8z0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXs8xEwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA3C4CEE9;
	Tue,  4 Mar 2025 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741105848;
	bh=7SSmhJywGvGXc8ZpfXpgY0nfMFXwgP1l6sL+dAYzJYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LXs8xEwPWUgdhyjLjpvHxsFPl+SiYytOtTnhGS7Hg+YqfKsElI3/5JEjyuQ79hX1e
	 MYYvB+NUnklV63UQclOVXfwzBhWU4GIJLbTB2NRo7tjjjQlg+ugSxUywpRly289oSa
	 UqcCCgsNBpfs5TryeYPiDFh6SL/8XdqYvc5ddJE6+EM5NsfQXVM6Ftgy5bKwXPe7nM
	 6c1X6ywJ6ISq5a6kCan/bcToHzW0eVQ/GXutQhyS/p4eB0G9E4XJwwKZO0nCnpY76P
	 IdSeRWHgJXzUXHEnxU1zqf+h3BNecf8cFWAIqxW9Rjrm77qL15kB00hHFYU0yNock+
	 YiAHhFsphxHmw==
Message-ID: <bdca9e9f-7e0d-4ca7-8e8b-f27ea8bb3b54@kernel.org>
Date: Tue, 4 Mar 2025 17:30:40 +0100
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <ovnmhbzwwimil3opuv6e2ayyntlx7upxfkzm5qdfskx2x7hl7x@wmtul33ttow5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2025 17:03, Uwe Kleine-König wrote:
> Hello Krzysztof,
> 
> On Tue, Mar 04, 2025 at 10:53:53AM +0100, Krzysztof Kozlowski wrote:
>> On 04/03/2025 07:24, Uwe Kleine-KÃ¶nig wrote:
>>> instead which gives you a more exact result. The challenge here however
>>> is that the multiplication might overflow. If you know that the result
>>> fits into a u64, mul_u64_u64_div_u64() is the function that gets this
>>> right for you.
>>>
>>>>  	chan->pwm_value = min(val, max);
>>>>  }
>>>> [...]
>>>> ---
>>>> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
>>>
>>> My git repo doesn't know that commit. Given that you said your patch
>>> bases on that other series, this isn't surprising. Please use a publicly
>>> available commit as base parameter, otherwise you (and I) don't benefit
>>> from the armada of build bots because they just silently fail to test in
>>
>> As you can easily see in the signature, this patchset was generated by
>> b4 and such tag was added automatically. No point in stripping it even
>> if it is not useful (life, happens).
> 
> My request was not about stripping it, but making it useful. I don't
> know the b4 patch sending side, but git send-email has the capability to
> make it more useful in this scenario. I didn't check, but
> `b4 --edit-deps` which Abel mentioned sounds about right.
> 
> The relevant documentation for the git side is the paragraph "BASE TREE
> INFORMATION" in git-format-patch(1).

Useful how? The dependency is on the lists, so there is no base-commit
you would know.

And regardless of edit-deps, that base-commit tag is standard from b4,
so what do you expect from all submitters even if this was not RFC?
Always base on known commit? But for most of the cases this is
irrelevant. I can have intermediate commit between linux-next tip and my
patch, thus base-commit will be bogus for you, but it does not matter
for the patch - it's based on linux-next.

Best regards,
Krzysztof

