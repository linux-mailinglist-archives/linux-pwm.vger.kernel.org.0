Return-Path: <linux-pwm+bounces-5051-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E803A4C266
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35856188C24C
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683D211A0B;
	Mon,  3 Mar 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="F6wdiybK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A42101B3;
	Mon,  3 Mar 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009894; cv=none; b=n5oeRv8t8YvWcmycuwu66QrnhA2VOkKrmMNjUnmNwON8wEem3kRVuRFhr4Ln+9HYBFfI7a1r9qqkuebMKSaXfdKsOgT16DKTY0oU+6ZepL80cO4rXavIGA6wtR8DmWGwNN3N5YV25MqBkoOfRrM1R0pWhp9tPD6M20ZPrX1oYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009894; c=relaxed/simple;
	bh=p4DhxoHd3mXOHoZ4y5+57jK7IJPUhj8owFfMXypcf4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qXUTT1wOALP7LRFsUG1SNOEhjXy+LodUvfLPM/YhoaO+pitqwkY3YUyVIFUZwzIZ7LKfjnISEXRfnhlPp2pTKkLha7/tOSENfsN4+cA272PH57fMGLU8eEvfL/p6TtO/UBxRlKoMMP931tzCSwJDJsr8/xJWIfvcrviP2Orv6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=F6wdiybK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7Hs006077;
	Mon, 3 Mar 2025 07:33:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ofmnRVwI5AT62ptxh8zklk/N01TYJ0oFg8f5/KIUZRw=; b=
	F6wdiybK2ED4uAxZOAJ/RRTtc+TbrgGGRp7AsLBjfNmeL1wxKEJe1gpttdgFAZQQ
	aygpqZQDL0He9/cn7WEOggadA7TgBV94vVupVnreLa1ZfKSWLnpeNovjZ0o9eyC/
	BDOwxgQ9w5V98ZV5k7y2uCBojEfbl6eO8A9BVEphTGXn+nG98/KF+LmSaCxm5QxL
	gwZnIK/MUTFJNIPctafUXvydaEtKH/23TqUrELy/xlvQCOc7TIdT+iOC9LnuDmW3
	q+w2QcBUh3Vxi31LaC6G+AMvTrlFW3vech1ZZUmPbzC0V4UbwTPa7El2/5x0XEV8
	jDLmZRWhEvTMuB7mDkGsEg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmcw74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 07:33:11 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 13:33:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:33:10 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E67B2820248;
	Mon,  3 Mar 2025 13:33:09 +0000 (UTC)
Message-ID: <84b7c543-7e81-4a20-9f58-7ddf6b2001e5@opensource.cirrus.com>
Date: Mon, 3 Mar 2025 13:33:09 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] gpio: arizona: use new line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mun Yew Tham
	<mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
 <20250303-gpiochip-set-conversion-v1-11-1d5cceeebf8b@linaro.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-11-1d5cceeebf8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CRfd2hqIDBqS4F2QrofR-T9cJdEBrOGR
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5af97 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8 a=IHiEukr3ZQpEQQ-4GLUA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: CRfd2hqIDBqS4F2QrofR-T9cJdEBrOGR
X-Proofpoint-Spam-Reason: safe

On 03/03/2025 1:18 pm, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/gpio/gpio-arizona.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
> index c15fda99120a..e530c94dcce8 100644
> --- a/drivers/gpio/gpio-arizona.c
> +++ b/drivers/gpio/gpio-arizona.c
> @@ -121,7 +121,8 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
>   				  ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
>   }
>   
> -static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +static int arizona_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +			    int value)
>   {
>   	struct arizona_gpio *arizona_gpio = gpiochip_get_data(chip);
>   	struct arizona *arizona = arizona_gpio->arizona;
> @@ -129,8 +130,8 @@ static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>   	if (value)
>   		value = ARIZONA_GPN_LVL;
>   
> -	regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
> -			   ARIZONA_GPN_LVL, value);
> +	return regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
> +				  ARIZONA_GPN_LVL, value);
>   }
>   
>   static const struct gpio_chip template_chip = {
> @@ -139,7 +140,7 @@ static const struct gpio_chip template_chip = {
>   	.direction_input	= arizona_gpio_direction_in,
>   	.get			= arizona_gpio_get,
>   	.direction_output	= arizona_gpio_direction_out,
> -	.set			= arizona_gpio_set,
> +	.set_rv			= arizona_gpio_set,
>   	.can_sleep		= true,
>   };
>   
> 
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

