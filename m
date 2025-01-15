Return-Path: <linux-pwm+bounces-4632-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292FA11F3B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 11:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88053A31FE
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC601236EC9;
	Wed, 15 Jan 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VW1JPJwi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D11ADC64;
	Wed, 15 Jan 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936696; cv=none; b=k1HB5N2Q+Lf7vspNnOWGJYdFnznnEwL8/k8OjwIZxJSIuB6qigs7EhlAoFSeTWGwb1nxDnoSbj6tUAjbOi4x00DBokXZvawOM0cqJYp71Ak+d3nXxV7RveVRO/V9IUhqWPoMIdaOhVOddaDYspg8G8yy1xrM16+0PgKGfPa4keM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936696; c=relaxed/simple;
	bh=ASAiw8WogvTogcir3ZVRnfw4mWDAzAHB2GlgWf4sjNk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/00Ecjz1isromPt4uZs7Oou3co6XkRwuljnR/nmkxmreIvF2wKpgRz2hhqwMHJ/F3sfPNzoK5feWtmr+WawTAcjL8GmyI5Cqn54e/9cLdE6Q3obMosCJzzhe2Ry3gP5HaLfEkI+0BSoGCKwKaOQzQWBlWvtHGysElodqAeK6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VW1JPJwi; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F7sWRc014640;
	Wed, 15 Jan 2025 04:24:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=F8fT8Kv+j/S2D4pOQn
	UFqbh6MfyYIrUfOk0KiOX87Jc=; b=VW1JPJwireF63R+LkAf1nvgCd4OhgbgcGo
	o9oqRq48//099FlqQg+hrWuLh26NjzJb4IumNFVQH0UApd/L8xoncuZ18dAoyk9e
	trJGUbZqhYvD/HMldUm3uONz+tCg74wGl53NBjMxBJVqLXXTNDNdEx3+BslIHULB
	XQn+wO1wI17r1fGEme0bWM+tIeOWC/j4etAsl2901S62Gq42kFccnhsfuAEUNiNn
	B6tQD0hORaBy/LPaDTgEHFuhvjEuDhiZTumorTk0lhtwEWodOs8UfDBdR5OdbYsd
	wgG+wx4ScyMZkWekMPAtIP0pp8zJnUhRxbRcwhFVeWW7m+uB2VNw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 443px4mf9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:24:18 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Wed, 15 Jan
 2025 10:24:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Wed, 15 Jan 2025 10:24:16 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 1508882026C;
	Wed, 15 Jan 2025 10:24:16 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:24:15 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Doug Berger <opendmb@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] gpio: Use str_enable_disable-like helpers
Message-ID: <Z4eMz06gm6DPjqsR@opensource.cirrus.com>
References: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
X-Proofpoint-ORIG-GUID: g_1sQD1C5vLD-t_9ffrlstl7qSLhk8gd
X-Proofpoint-GUID: g_1sQD1C5vLD-t_9ffrlstl7qSLhk8gd
X-Authority-Analysis: v=2.4 cv=XdhzzJ55 c=1 sm=1 tr=0 ts=67878cd2 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=VdSt8ZQiCzkA:10 a=Q-fNiiVtAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8 a=4kLLQdw-iMVuSiU5jB4A:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

On Tue, Jan 14, 2025 at 08:14:38PM +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

For the Wolfson bits:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

