Return-Path: <linux-pwm+bounces-5239-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1952A68B5C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79801893393
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FCE25A34D;
	Wed, 19 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VufXH5Rj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC025523F
	for <linux-pwm@vger.kernel.org>; Wed, 19 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382824; cv=none; b=sPbGovOK7wQB4SaeZ3ovrX7G4FBFdQUCYoD3UA57flMTa9pC4jm6J6/TBuENu9OjngpZmAyOjH2kPW63/w9+s7dUAPOxvb2Uv9Yv7yZwsehrCsmaw7MEtKiXKqQLhlpY1GDr1bQT0TX+pm1+g7A6tdi6h5az+JRk4wFKeM0d7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382824; c=relaxed/simple;
	bh=eM1NFwNHExQMu9IqlxfrNERkiCBjA0eydss8KyJJbgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLz69q1b5YGHs8nsRUYPh/0ipQGcXkNkEztjZlnjighpz5JxwbmkOWSHhltqU8FSLRqi5mo2h7PwGtD5J0U15mqwfEi7xHO84dRpoeTjzj3jx21MPK0P6VIuS6QyfgJq2/xcgZ2XcuAQoiPotAeahEtDF2gq1EtzNVb/fbXlnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VufXH5Rj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bee278c2aso6768591fa.0
        for <linux-pwm@vger.kernel.org>; Wed, 19 Mar 2025 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742382820; x=1742987620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM1NFwNHExQMu9IqlxfrNERkiCBjA0eydss8KyJJbgQ=;
        b=VufXH5RjCnSbxJndaVGG+arlQNRDtC/uzxFIp9SbOng+sOLtgmCDOYrJe+kee9PBuz
         jkrkcAnNxMWMoE+qKsKrd8EzM7vSIMdS1+jWzXWEij7A02YN5Yn2mxzdHmDgckYljNVD
         7H31c45EmsRQvM1ei1KA3sRohCMC2UZbFLo5W+oa23wGA7xohspUO/z8Gk1+C7yfg9rs
         SSyM+OWDQ8zLo8cYL7DdcsFag0UgciW32k1EiJS3RQg99vcntU0L9XEmP5pG40ala14n
         bYpOQ68slv/AjQfnRFmZmtwelvpN8e/5Twpbr7HqbOX/GqnkSQc9LXm3b7EupxeqEOd3
         XF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382820; x=1742987620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM1NFwNHExQMu9IqlxfrNERkiCBjA0eydss8KyJJbgQ=;
        b=OtgpJxatfg2+gv/B/SP79J7bUjqZfyaasOgfot7VqZnlHikZxHg7k7p88a6P++LffT
         gF6VxnGblcQ45AreSv31RXYchm/7nI715Rqpsr6GCZOMaWmfBts8mfhdBptz9R/tK1aU
         DzOpMN+vEd3Yywj6fLVARW13XjpWWNykE8pwmc6qTM4lsePjLMLQLcylNW0QN0+RPS7v
         qMBeh1SpCE4DcsJAX6P3OAA6DqABRPuD8tbX4mLSGHqqssvzpsXFvO4Gi3+aR+BneHCx
         4PJPOGdPHPjmkHXqr4A8BzO9IWm5vAz4Al8CPCwuv+Ilh5X5lT8ccQPTvkFBckvUtcYB
         UPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXUaRrxxI4+iKpIuF6152QKihWfmDo3bSJlX4z/rapS16FbhI9oJd5egnZT0pLMIlByd/mTMW/gmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZNwVueDv5YxfbRq6qcCk5NGRjaotyegEULW0EHClZspaHtlI
	dRCUriZBWjY/fbgnKGr6HLl9USXgnBa74+lLJyag2weaz3NDUkr3MHCm0P/UJmL17Jko2dNJ36B
	1WAuhWBQwDiVBjNQizie6dTOigcrA00du1K99Ew==
X-Gm-Gg: ASbGnct+VdiWJZIb8EChYaZxEmMKX0Ff59RvArpGpVnnQvPZaSZp8Ei8LGW2HXcSIAa
	g06cDFLHj/3Ax4QlTWxLxgVeyEw49Tz7HdbIwc0Vxf8Epzk993Ws1FvogOP2DOXu24T/DoSlCnm
	0WjfjyMSDBbc0FcXfVlWqfxmUntA==
X-Google-Smtp-Source: AGHT+IGC6Ct6HFPL2vEp9At/inBMPgzs8sxHCIO/aS1qZLyW0rZUkecws01dh5D4an+xPjvVxC7ooHe2QmSBoNRyYSg=
X-Received: by 2002:a05:6512:3da7:b0:549:90ac:cca2 with SMTP id
 2adb3069b0e04-54acab43be7mr912779e87.1.1742382820322; Wed, 19 Mar 2025
 04:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com> <20250318-mdb-max7360-support-v5-3-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-3-fb20baf97da0@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Mar 2025 12:13:28 +0100
X-Gm-Features: AQ5f1JoKYGT4lUy8nZOG2LsqkFU5YAmf-ngKXbzyf3RX7_XIhXpPO4Vz-qGj2r8
Message-ID: <CACRpkdamZV1ZHf8JNLMu5zby4O-NRwES_F4BCd6DByytSKSqCw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] pinctrl: Add MAX7360 pinctrl driver
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

thanks for your patch!

On Tue, Mar 18, 2025 at 5:26=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:

> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> can be used either for GPIO, PWM or rotary encoder functionalities.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Overall it's a clean and simple pin control driver, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

