Return-Path: <linux-pwm+bounces-911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA183A529
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 10:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAEC1F24014
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62618AF4;
	Wed, 24 Jan 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lNPdkd1a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CC182DA
	for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2024 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088013; cv=none; b=T77Vt4zOqBnHcPOaFqQoqIzmD1b5BPZ1wOFzM75yKBROuLqrDhPBMpZuTnouVfnj3NlAzaUeeJnPbL/z3jAPuMj4buE2PWBfXRHmQskadvNRqHTDBXZNQ5VpFq9ZKgTOMG/1SJKGuoC/upDoNtIPOPmAgFVKz2WRsJZC2h83LBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088013; c=relaxed/simple;
	bh=SEqCpZT6APAqjYjHdfthclsSjN9J9NtcFcgDByg6704=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=mIxA0fzD/+94E+ts1kUPaG5Za66PUie9Yl8WhIVVHgM9WIqcrBoBqK4UTUV4nbxr5Gj1Y/mhekx/cZuTgwJ08IhG661n0lyUeADaY06VbIHwGK7RawN94S87VcOVGcipyU5SRUNK8R2LZPzrRO9p9/lzhMC7ulRY3MFejbtK5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lNPdkd1a; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cdf69bb732so56794401fa.3
        for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2024 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706088010; x=1706692810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKfrsIh+is/CrcG9RcsWASRz9/Tq/yuaNYUtRHDrGYY=;
        b=lNPdkd1ar7PFVviCpzhXDewaVecUKlLnzjPk3HY9rmPz59I/WszYxTx6SG1hoInhWf
         NMDDJ2kISFP7DNQk7x+JsHcomdQ/UrL3VPCrY7jsqwau8sprZShZ5ZLwfynfXCkpGRY9
         IqAJKpuFgvKbpraglPjNItwmJFG8NgIWv/S+HhNwAmOuVHuwYdP26RPGT3qP4TbaS37a
         A6DWoc/cyK1dhjrcj0MI84jXqnqatCxK5ZgtPXUYckNRi2WnjhFOW/NrKjSrFtFnHt/v
         m0EtZakTWAtFUDnXOCMKW2AZfLCfG7E2yvS0PrbOHoAKvSjPnCqW7X0WH6DZdpdet6v0
         cQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088010; x=1706692810;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XKfrsIh+is/CrcG9RcsWASRz9/Tq/yuaNYUtRHDrGYY=;
        b=W/q5Se3Cn7jljL2HuizTIZ+qmQU5RVEN4BRPWiL/PM/RCQ4rKftM74YlB98Uf3mi/z
         fy+rvqXZ30vHw6126GyFoH/TpSHg7HhgG0A8GtUII3W12I7y3mQXo2kfcVbKvi79JDxK
         dh8/XQh6p/vUkmnWNF/XAQBjeyyn5QBfP6O1/Sv6RwvT6XaZoX1tvBSsE2XzGFBt8r9l
         fFmVWdNKoxwje0TzpLruRGs6bJ8YUwBEgop1BT9OxD2c0oqnAPwDiYqqh5esReKCUl0T
         8NDWJERZJmDu2Gywn5f8Q+AoBnjXcHTHqJ7GEzB1tllueOztNqRkPB/wC0PJcSTAlrkY
         7IgQ==
X-Gm-Message-State: AOJu0Yw5lLSxd6FKJfMbFe2NuZAMHJccTZCx4qherhsodLyfHAxWidNf
	9tq3HOmpSs3EwPPhXjnvytUh+ClhszUsSDavvk7VN+sVd83HS1RP7EGmUiPKpvE=
X-Google-Smtp-Source: AGHT+IEZUUso/GaClxXInQJERF5pL3kfwim7rmyD5VQKB34/cKfjEP6E08ieSs6LZXIkiNyWTfvtDA==
X-Received: by 2002:a2e:9c95:0:b0:2cd:5cfd:b13 with SMTP id x21-20020a2e9c95000000b002cd5cfd0b13mr332903lji.17.1706088009899;
        Wed, 24 Jan 2024 01:20:09 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d8b6:17b6:386f:c67b])
        by smtp.gmail.com with ESMTPSA id bw12-20020a0560001f8c00b00337cef427f8sm15938313wrb.70.2024.01.24.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:20:09 -0800 (PST)
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-6-jbrunet@baylibre.com>
 <gyhea42rtydw3g45lfkfbxfm6xcbwibz67vw7xke2sm7powz2a@i33g4pyanu4l>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding
 <thierry.reding@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 5/6] pwm: meson: don't carry internal clock elements
 around
Date: Wed, 24 Jan 2024 10:16:17 +0100
In-reply-to: <gyhea42rtydw3g45lfkfbxfm6xcbwibz67vw7xke2sm7powz2a@i33g4pyanu4l>
Message-ID: <1jttn3w0ja.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed 24 Jan 2024 at 10:02, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de> wrote:

> [[PGP Signed Part:Undecided]]
> On Fri, Dec 22, 2023 at 12:16:53PM +0100, Jerome Brunet wrote:
>> Pointers to the internal clock elements of the PWM are useless
>> after probe. There is no need to carry this around in the device
>> data. Just let devres deal with it.
>>=20
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pwm/pwm-meson.c | 67 ++++++++++++++++++++++++-----------------
>>  1 file changed, 39 insertions(+), 28 deletions(-)
>>=20
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 15c44185d784..fb113bc8da29 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -90,9 +90,6 @@ struct meson_pwm_channel {
>>  	unsigned int hi;
>>  	unsigned int lo;
>>=20=20
>> -	struct clk_mux mux;
>> -	struct clk_divider div;
>> -	struct clk_gate gate;
>>  	struct clk *clk;
>>  };
>>=20=20
>> @@ -442,6 +439,13 @@ static int meson_pwm_init_channels(struct device *d=
ev)
>>  		struct meson_pwm_channel *channel =3D &meson->channels[i];
>>  		struct clk_parent_data div_parent =3D {}, gate_parent =3D {};
>>  		struct clk_init_data init =3D {};
>> +		struct clk_divider *div;
>> +		struct clk_gate *gate;
>> +		struct clk_mux *mux;
>> +
>> +		mux =3D devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
>> +		if (!mux)
>> +			return -ENOMEM;
>
> I don't like this change. While it doesn't increase the memory used, it
> fragments the used memory and increases the overhead of memory
> management and the number of devm allocations.
>
> Are these members of meson_pwm_channel in the way for anything later?

Not really. It is just not useful on the SoCs which do use it and not
used at all starting from s4/a1.

What about a dedicated struct for the 3 clock elements and a single
devm_kzalloc() instead of 3 ?=20

>
> Best regards
> Uwe


--=20
Jerome

