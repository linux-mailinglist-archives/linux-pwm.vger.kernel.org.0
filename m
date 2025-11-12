Return-Path: <linux-pwm+bounces-7620-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0297C5111B
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Nov 2025 09:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6813D3AFC62
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Nov 2025 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32025274FF5;
	Wed, 12 Nov 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XJunkJy9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49380192B75;
	Wed, 12 Nov 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935362; cv=none; b=W8cuEEW3TsYoU5J6uBA3STJTnAdad3dGx92Z66e4Xz7bs46bGKSvjPgQ9ZqSMAJgSIxgxkL7mom86cY97YsU6NTr5vFq14cLD3ap8/ba9n3QQeG1v0Xt3pdGyR5E4s1QnoHDcxhnDQGv7pMW0uazSFscDMKNe2Ma+QF9i5EqaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935362; c=relaxed/simple;
	bh=9lFttpgfwCxR4/Gzin67BEKLTz/k+N1q4qSXGFW78SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyRvbgiZ3oqvZTZQYvYHX8iJi2Xo/H4sjPZ0TyBC8mQFVmv1GRTVrb5EFkzRpAzv34IX4Rf/alH8GLj31TdLhC8nYEVfzeKRSzQgLuXObBOIqlWlkCM84V1P+pbhXituC9q69tmGb2VoUp6T94yiqcorNxvazfiQicxhN0Ai9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XJunkJy9; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=m6Hg0b+Cx/Cb0iRwkxFZolAmLia6/s0EULb1X9hfULQ=; b=XJunkJy9awKsvjlf
	rqrR1kFrwJ3DlpDrrY200/436zpH7zeTGPItqM5PcBKQrzxCsHu6j7h0vA2wnMKAK9Dk/TW/Fo7lX
	cgzT4wZP/UkFcnUk363bJ+Kknc+kDyDGnK4+iYfqKVlV4fdFix8rKFnoWFgR5xa32SFa5M32eD2U/
	mosJ9ZR4egncphjUfpHa57S7oxb8ZKUAuUeWDOUUl6/KLuE4IzQQlCA9sqILcL2W5eeTqhe++x2mz
	MXVFHeY/9Qa3ENw2/TFIV7wl954b+S6u1Sc1TRLOCxdgjC3obxz/8nC9qRVZcKaCLBUfaffb+JakP
	RgCW/YSdDdPrsFerfg==;
Received: from [63.135.74.212] (helo=[192.168.1.241])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vJ5Ly-003ih7-9S; Wed, 12 Nov 2025 07:33:18 +0000
Message-ID: <0bdd6ab6-bfdd-400e-99b6-cfb186dfcc3e@codethink.co.uk>
Date: Wed, 12 Nov 2025 07:33:15 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] pwm: dwc: add of/platform support
To: dongxuyang@eswincomputing.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 krzysztof.kozlowski+dt@linaro.org, greentime.hu@sifive.com,
 jarkko.nikula@linux.intel.com, u.kleine-koenig@pengutronix.de,
 linmin@eswincomputing.com, Ben Dooks <bjdooks@googlemail.com>
References: <20230907161242.67190-7-ben.dooks@codethink.co.uk>
 <20251110090508.739-1-dongxuyang@eswincomputing.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20251110090508.739-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 10/11/2025 09:05, dongxuyang@eswincomputing.com wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
> 
> Hi Ben,
> 
> We're currently working on a platform driver for the DW_apb_timers PWM
> controller used in our EIC7700 SoC. We noticed that you submitted a patch
> for a DW PWM platform controller back in 2023, and we would like to kindly
> ask about its current status. Do you have any plans to get it merged
> into mainline?

Hi, I think we got a lot of the code re-ordering in but never finished
as the project came to an end and our customer decided never to ship any
actual silicon.

I am not sure how well our patches will apply now, but could have a
quick look at this to see how much is left to do.

Unfortunately we had to delete everything at the end of the project
so I do not have any sort of test setup.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

