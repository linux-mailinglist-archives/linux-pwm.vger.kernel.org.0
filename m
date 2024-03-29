Return-Path: <linux-pwm+bounces-1838-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F3892003
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297D6B34364
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702181752;
	Fri, 29 Mar 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SmPkxfqi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526CF85942;
	Fri, 29 Mar 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721386; cv=none; b=ePHCtSv2gxOCjUa1Gh2NEZ1gHChiMgd9l7lg/ZMcHpTdqMscYM6CltDNxcmS/EsUucYzVj7YpQ2lY2ESOjek8xjKc1ypmN80vIUNIKv+AQ+9CulCSvfeNSeNbcxHCSZqVo5JAbfYHXX/ToenV/YzgIDozRotnUjMq4aTP4OUJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721386; c=relaxed/simple;
	bh=7BXu3z5aWHgSwjpVC5g+uQXoiZ7sf2zEb76J2er2REU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar8w9zQlJvVDvKXwZzz+OI1jXuQO7fQ1yBuABga44TfUxaXdfyloGbjhdz0HBLNTqSXt5L75Ah1SpytF6ahh47M5+0MPeVHUg4OZwiEszUD3ZOm7AQPc0KDG32BSZQxubILoDzKGZhbNX8bHIe/5g3NNAfrQywsjDTSi2gDN5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SmPkxfqi; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=tnY6mjvKmaqatppE95jsbuYCoBKw4Of7/2hkJ0TnT9Y=;
	t=1711721384; x=1712153384; b=SmPkxfqiiMyMj1p8u9z7DICvpOa6Ch/p8/+CixxzlHGVRLt
	JZCf5N+5DxTP/NLAg9bAjSryiEFSL3HohrJKXwLmptxG9rZQ90G94rMy6qUTL+s/w+Nwbjl7JW8k3
	WeriHuEtPMRP5m2CyAH5Uyw/MixQgqOv6I88V5grmnVGarofwXkA8aTg1jGil61xxttejucDDIwrh
	Fd9MV3vZ0U4xkVnH6g0qcJmFA4uy/qgYgrnObRADoWuMwmNe5q0tv6msZ6xZ+1YrMTcCwohJ1kgps
	dlX8J0t0Ml3+0JVdIWIokuIifhdX3zz2fhZXPgYAIfxkYE1+n6PfKQEFQW2RrSJA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqCvO-0004AK-5m; Fri, 29 Mar 2024 15:09:42 +0100
Message-ID: <2e7ef1d2-ecc5-49c9-96e7-e479f0e5e3d8@leemhuis.info>
Date: Fri, 29 Mar 2024 15:09:41 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: Fix setting period with #pwm-cells = <1> and
 of_pwm_single_xlate()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Karel Balej <balejk@matfyz.cz>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz>
 <20240329103544.545290-2-u.kleine-koenig@pengutronix.de>
 <D06708BSGQ0J.1L4YOKOADM7T6@matfyz.cz>
 <v5jwouykt37up3bcjiigjgipzfdwgo5cguskunxjmyags43gql@dmrcrynj4zvj>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <v5jwouykt37up3bcjiigjgipzfdwgo5cguskunxjmyags43gql@dmrcrynj4zvj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711721384;6978f1f8;
X-HE-SMSGID: 1rqCvO-0004AK-5m

On 29.03.24 14:24, Uwe Kleine-König wrote:
> On Fri, Mar 29, 2024 at 12:21:15PM +0100, Karel Balej wrote:
>> Just a nit: I am not sure if perhaps this being part of the report
>> thread is sufficient, but generally there should probably also be a
>> Closes: trailer for regzbot to automatically mark the report as resolved
>> among other reasons.
> 
> I applied this patch and added
> 
> Link: https://lore.kernel.org/r/D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz
> 
> to the Signoff area which should be good enough to make the regzbot
> recognize this as the matching fix.

Thx for that. FWIW, those tags are not only for regzbot: they are older,
as Linus wants them for good reasons[1]; that's why the docs also tell
people to place them[2] for many years now. But a lot of developer are
either not aware or ignore that.

Ciao, Thorsten

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

