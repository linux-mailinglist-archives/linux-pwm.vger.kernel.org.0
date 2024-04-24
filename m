Return-Path: <linux-pwm+bounces-2062-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C260D8B057E
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 11:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A328CD02
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AFA158876;
	Wed, 24 Apr 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oiE7Rbnh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266F14F62
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949712; cv=none; b=iGvs6TLWwenNs/dRaQktztXAbyIHG56alJ78DsjtVhGmqjDyy3bvDUV3YeoS/6+wKe6MjRp4hiBFoQDpvFZFlp5LXKQq2cilabeiUwjCHXm8rkpZ0ofUWOShRUWOaNSjyJ3nc5USuqbwpCCpS+FngF0sgqiYDFPMY1A529GxK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949712; c=relaxed/simple;
	bh=Msw/f+57MQK6afEMuOsBELp1SeA+pbWBBWPgm728e/w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=oabl4ULTI14WmXd+v+cZAq4XavmavpnNHqf+5yhrDvMFtjOOOGBG20pZTwOelYcC+w8FTX2z4layqw8fGw3Dn6lgdN20h4jRYmRh1LkGWHzq05cADNn+19yk3Mest6X8q7rF6wC0hOnVqwC2O9BvcQSSasdso47PrqWeeyoNBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oiE7Rbnh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so50407145e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713949708; x=1714554508; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rvbtxxL0KA7+nw2JDrdSITHMot8lmC1r+u81WvHz+K8=;
        b=oiE7RbnhV18YVH9BixeqGUZG7Mo7pfAHwvHwP0KOjRp2OOqcHvxFUSKtXytKyBHN84
         vwMWIMGM1yCzP+wlrsjGtkY2WfYtlnqIXgAmb/carwV3IVMHokmara41dAFQISTfC9Z6
         kziTT+FLknabpZjQ9vLHblcFpFuDyJHDz3mg5N5iCtpQwe9H87RKSWWInGgic1NB3I6N
         xyE1PSP6fiqM9yMXMMeARWDQWI9SSlsQTfqT8RnRdjV98Wm7MaINY+TpWTfmBCgvmgty
         OZ88sp1TnckNb4CMmDe0j8FaytMnEbVzlC0PYdrP7TbYopy/0QvhvoAL6iN8ksWElfNG
         gi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949708; x=1714554508;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvbtxxL0KA7+nw2JDrdSITHMot8lmC1r+u81WvHz+K8=;
        b=HLl+bEKp5UoJ35YtxxpYuyKJzeFvXCN1aflsz0D8BMpy6LOIY9a1lM6RzQJrfnRLLY
         upY1tjb1LtY6lw0jqUcg0s3990CATD+22x6k5+15RgNM30+x/O0btCRvrBM3OR4yH3p1
         BNwUjOKuq5juAYNpPkx2mVR893CA6ZRCZL4A6tKSmvNNbUfHCnfaiJr29BpaH1z/fKfX
         +JtEHOfKdyHQ0fwLZYYBlhhIavAujQT1OpBLV14OlCT7gd+Cyt0peraxJo6I+AykJbeC
         oJqKPQ623FuTjyr3Bh01GxHjk+9eE3J1bAPmTWpiv6Txy5XuAOFv9vW4gVwNThSnp2yy
         4S+g==
X-Forwarded-Encrypted: i=1; AJvYcCUDr1dszHgcayIMbp9s6aN7EVOHhNoXDZ6WfH0WGXWNJb1T0Xzj8lKwr9nxAulpqF/IXiX7dHcmR4Pp3SVkWs4Tc+HlpzmPGxjg
X-Gm-Message-State: AOJu0YxBfWuslFte4C2t6f4ekeZb1S/Sm2I8su/IIg8d9YIhMX3O0JiM
	iGNKLo0ycvFT2iszAUGqH0aJilFNG3BTNZER40cQamIAb6i2KUVxjgoBGKd7zAQ=
X-Google-Smtp-Source: AGHT+IFezzal7JjWvHMGZYy61bCLzRhsiQD5U7WszFsfXL9gRrzNRJlTMjBSCQ2VYQubwKxlAGjtSw==
X-Received: by 2002:a05:600c:468d:b0:418:f307:4b82 with SMTP id p13-20020a05600c468d00b00418f3074b82mr1358453wmo.39.1713949708334;
        Wed, 24 Apr 2024 02:08:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ab48:1b7:631c:952a])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b0041b0d4e1c27sm987467wms.42.2024.04.24.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:08:27 -0700 (PDT)
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-3-gnstark@salutedevices.com>
 <1jv848ezzo.fsf@starbuckisacylon.baylibre.com>
 <4feb8fe3-af72-4483-87b2-30503328cfe2@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u.kleine-koenig@pengutronix.de,
 neil.armstrong@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, thierry.reding@gmail.com,
 hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com, George Stark
 <gnstark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH 2/2] pwm: meson: support meson A1 SoC family
Date: Wed, 24 Apr 2024 11:02:10 +0200
In-reply-to: <4feb8fe3-af72-4483-87b2-30503328cfe2@salutedevices.com>
Message-ID: <1jmspjf7qs.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Wed 24 Apr 2024 at 02:00, George Stark <gnstark@salutedevices.com> wrote:

> Hello Jerome
>
> Thanks for the review
>
>
> On 4/23/24 20:35, Jerome Brunet wrote:
>> On Tue 23 Apr 2024 at 19:10, George Stark <gnstark@salutedevices.com>
>> wrote:
>> 
>>> From: George Stark <gnstark@sberdevices.ru>
>>>
>>> Add a compatible string and configuration for the meson A1 SoC family
>>> PWM. Additionally, provide an external clock initialization helper
>>> specifically designed for these PWM IPs.
>>>
>>> Signed-off-by: George Stark <gnstark@sberdevices.ru>
>>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>>> ---
>>>   drivers/pwm/pwm-meson.c | 35 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index ea96c5973488..529a541ba7b6 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -462,6 +462,33 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>>   }
>>>   +static int meson_pwm_init_channels_ext_clock(struct pwm_chip *chip)
>> That kind on naming (ext) is almost sure to clash with whatever comes
>> next.
>> Just use the name of the first SoC using the method, a1 for instance.
>
> It's true that pwm core in a1 s4, t7 etc is the same AFAWK.
> I just want to clarify your proposal:
> I add a1 compatible to the dt-bindings with s4 as fallback,
> t7 compatible will be added later in the same way.

If you know t7 is compatible as well, please add it to.

Other people (including from amlogic) have responded to thread around
the s4 pwm topic. You should probably Cc them of your future submission.

They may help test and review

>
> Here in the driver I don't mention a1 at all and use s4-centric naming e.g.:
>
> {
> 	.compatible = "amlogic,meson-s4-pwm",
> 	.data = &pwm_meson_s4_data
> },
> static const struct meson_pwm_data pwm_meson_s4_data = {
> 	.channels_init = meson_pwm_init_channels_s4,
> };
>
> right?
>
yes

>>> +{
>>> +	struct device *dev = pwmchip_parent(chip);
>>> +	struct meson_pwm *meson = to_meson_pwm(chip);
>>> +	struct meson_pwm_channel *channels = meson->channels;
>>> +	struct clk_bulk_data *clks = NULL;
>>> +	unsigned int i;
>>> +	int res;
>>> +
>>> +	res = devm_clk_bulk_get_all(dev, &clks);
>>> +	if (res < 0) {
>>> +		dev_err(dev, "can't get device clocks\n");
>>> +		return res;
>>> +	}
>> I don't think allocating the 'clk_bulk_data *clks' is necessary or safe.
>> We know exactly how many clocks we expect, there is no need for a get all.
>> 
>>> +
>>> +	if (res != MESON_NUM_PWMS) {
>>> +		dev_err(dev, "clock count must be %d, got %d\n",
>>> +			MESON_NUM_PWMS, res);
>>> +		return -EINVAL;
>>> +	}
>> ... and this only catches the problem after the fact.
>> It is probably convinient but not necessary.
>> 
>>> +
>>> +	for (i = 0; i < MESON_NUM_PWMS; i++)
>>> +		channels[i].clk = clks[i].clk;
>> channels[i].clk could be assigned directly of_clk_get() using clock
>> indexes. No extra allocation needed.
>
> if we use of_clk_get then we'll have to free the clock objects in the
> end. Could we use devm_clk_bulk_get instead?

Add the devm variant of of_clk_get() if you must.
Use devm_add_action_or_reset() otherwise

>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>>> @@ -500,11 +527,19 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>>>   	.channels_init = meson_pwm_init_channels_meson8b_v2,
>>>   };
>>>   +static const struct meson_pwm_data pwm_meson_ext_clock_data = {
>>> +	.channels_init = meson_pwm_init_channels_ext_clock,
>>> +};
>>> +
>>>   static const struct of_device_id meson_pwm_matches[] = {
>>>   	{
>>>   		.compatible = "amlogic,meson8-pwm-v2",
>>>   		.data = &pwm_meson8_v2_data
>>>   	},
>>> +	{
>>> +		.compatible = "amlogic,meson-a1-pwm",
>>> +		.data = &pwm_meson_ext_clock_data
>>> +	},
>>>   	/* The following compatibles are obsolete */
>>>   	{
>>>   		.compatible = "amlogic,meson8b-pwm",
>> 


-- 
Jerome

