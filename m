Return-Path: <linux-pwm+bounces-3436-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015798E125
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A08E281816
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFDA198A1A;
	Wed,  2 Oct 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="oxyGFHuV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6538DF9
	for <linux-pwm@vger.kernel.org>; Wed,  2 Oct 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887564; cv=none; b=ephjc2IOG5kOt0WaaUtLYHbMvZGclGO10wjfGRwOtsNXn68Bn1Ya67417hEnz7AbcvBbVqTxTah0oX6LXI5MR0VRSRtNN29kPUTe/4lIieivCv9vQ2Nwyld0EHp1LDH4irm1UgmdJR2UaDHWyl1LC97h+cWKyWdpvNTGnz27NRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887564; c=relaxed/simple;
	bh=S5oWTL07Z27zMnu/W4EqJbn2gKD9ls6Wmzpi8m05GrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk9KhgfKa9pZPe9QEiMpiqnYHD61U/JDtpAZ80x2pVbx45XcKxDKT3lKYHjX30NNrJe4hwB7H7S5Re+ol2nsuwbzBTI8WWUyF5Yzxn5hRKJJ3iDAmWnS+DdPqwbhuvotLY9t0gtsnFHdIhpy5yPs96+Cvl80FfksH5/pmxAh9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=oxyGFHuV; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1727887557; bh=S5oWTL07Z27zMnu/W4EqJbn2gKD9ls6Wmzpi8m05GrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxyGFHuVJOfD5lPU2ru/RnfzDFVxqEqK/hSOYnaJgmQdXwA7N0cvxy7wCe49hL9d4
	 Pojkx+Ms79FG0h9hIm502IKf1Wr20lr7rsF/MbAiZcl69DWef3Sa4Ld22fdFzKYDd1
	 M+EW0xm1T+EKPOyJLynRIxFKNzP/jIq0bTmfC0H4ipySvqrbZe1/b+ZO3eLQnFQQ1q
	 zIGzZB8sp36TVVcbBlf4vuf3WdEic9xiHCrbhp/ZhOO7v3RUe6iFRJY1EHZ3ulzJ5T
	 6NlZ46Ym3iaoR/iUHHN67vuYH0FjQBZD1ckpHUMz1B+lae48K0/eoyfXl+m4MAqyd1
	 yL1okg/F1KelgcW58wj+Bvjk1BL1yF5owHzYd5Ll/JgJ1KTZbfDAicex23+Tmf3Pkz
	 c65Ie9h61N6voS65s4/MlFDUCE98g8gCUbasg/vIRX7zisLzShFa/Fj+OVCEtjjBwP
	 gK71ompUfwPA6FpZ5E6x7ORfDGcMipQcUtrqSGIbRr1ECvHL/sfriXC8Ra/xbCJ3RW
	 1CIWCy94G5JXY11/UUu4ix2MgW+KUvmNfQpymtM8DQJG+mU/7gJ9g8FVdIRE51su0l
	 oguxGwISAQSaeqLPm+XbDgpcvISu0YP6epS8GbdyXmmxEtU7K2Uh3LSSQ+8UGNF6Cv
	 9HvBqZAsTgV4HK3h+d6rmxWU=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 300C0168387;
	Wed,  2 Oct 2024 18:45:57 +0200 (CEST)
Message-ID: <cc8e3a21-ce15-472a-b838-3dc6e80f68e0@ijzerbout.nl>
Date: Wed, 2 Oct 2024 18:45:54 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] pwm: stm32: Implementation of the waveform
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>,
 David Lechner <dlechner@baylibre.com>, Kent Gibson <warthog618@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <332d4f736d8360038d03f109c013441c655eea23.1726819463.git.u.kleine-koenig@baylibre.com>
 <b0199625-9dbb-414b-8948-26ad86fd2740@ijzerbout.nl>
 <wl4wpipx2jaixlmdjv7uq5ghewwid5wo6gpmz5bkqj5chnu3vc@6bougxe3rzbx>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <wl4wpipx2jaixlmdjv7uq5ghewwid5wo6gpmz5bkqj5chnu3vc@6bougxe3rzbx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 02-10-2024 om 10:02 schreef Uwe Kleine-König:
> Hello Kees,
>
> On Tue, Oct 01, 2024 at 09:17:47PM +0200, Kees Bakker wrote:
>> Op 20-09-2024 om 10:58 schreef Uwe Kleine-König:
>>> +			regmap_read(priv->regmap, TIM_ARR, &arr);
>> Did you forget to assign to ret?
>>> +			if (ret)
>>> +				goto out;
>>> +
>>> [...]
> It seems so, yes. How did you find that one?
>
> When I create a patch, is it ok if I add a Reported-by: for you?
Fine by me. But I have to be honest here. It was reported by Coverity [1].
I'm subscribed to daily reports of linux-next scanning.
>
> Best reagrds
> Uwe
[1] https://scan.coverity.com/projects/linux-next-weekly-scan?tab=overview

