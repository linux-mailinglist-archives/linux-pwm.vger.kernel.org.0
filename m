Return-Path: <linux-pwm+bounces-5510-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91939A8AB2B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 00:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1D01903763
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD628469C;
	Tue, 15 Apr 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgJo06PG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2427A108
	for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2025 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755346; cv=none; b=ib+Rcf/Vpjd5dc5EmcFFvRW/0GWjpoKSC7VPuLDuOaLl89UFD3T1d79RO7QHo0ADbUhsuC57+qMtrfrYZLP1UNi19PfIxXFRcNpW9/ooR7Uw1HpRJyKXVgtxIAPNC96PiPZqxl4SgWbsS0pqPbNyl/2KYT3wsdS+WDzovc502tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755346; c=relaxed/simple;
	bh=3IDLTt/ybfWS/Yh/QoGmWJI4cRQW9Qqw72xuwSQQoz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CapWVNPgPyqHlpwFOS3//1WFl7cqfO7/AW+8SADEXih8NQgTdnX4QbR2Dq6XPii2r6WgWf5UapbczvT7b3BzjFIKRTUkrFaidc2RIJd3yEyM3VO9cHHR7jVcjzu5NfDks62Rd9W6wYvvQTymAzIq4bzpVU83YsCa4TCoAuaZIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgJo06PG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so51506001fa.2
        for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2025 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744755341; x=1745360141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IDLTt/ybfWS/Yh/QoGmWJI4cRQW9Qqw72xuwSQQoz4=;
        b=xgJo06PGDjE/C/mqIWjOtCx+0tQ4IRb+or3O9QwH22qaijmjDXXgIC+KJLlZRXFUTV
         lIRVucqzW0Cdj4mB8TpzbuWFH7NFlOuf8czjP9eTEUKRIqdfYOItvy8N02+wlzXiw+f3
         Lzqpx+0Sz6A6GfVcnWcAK3hlAWh5IQNnA9sFbkCqTkqpi2y/eBs9p3lLjlwf9d7dsFKm
         TH5v2wnS3qbIlHqTAE5c8JEOySBTjuzL0TqfzJ0DJ4gX4PIrs6EROu0+X59Ewl0tr2CY
         WMwnFWHcNGhgAvfl0MLUvqriC80GW8TRApplSAHMMoux5wSMY2X6Q/4or2NOXe3nsP92
         J3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744755341; x=1745360141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IDLTt/ybfWS/Yh/QoGmWJI4cRQW9Qqw72xuwSQQoz4=;
        b=jvD94oGOB3O0jeHawIhaxoTvNyBn/pdthaCAILs1NWYd524wwuag+MateHPe2iteig
         WVAsrQvhh6drGixPkiea+U3ZQao6l+w8kDU5tlbkuX+ctqwT33Bktbf8j+3wPNuxr79Q
         YFuFWSmRNGi5oqUEvpNocOksFY3mCnuTxTuxUrzqUXFz8px3Pwgpugc7hVPZryFzOfEG
         VZVLpAUl/F6XWizTOyOQnH12bqOPZP6L7goSuTmmRRlTzKgIUix20/pbzF9hwUXUKGQI
         AZuJkHM3fbPVGhBpQflKYD0R+xdt28f0UbitWzCBS0IkPwDXDCXcujyaHJ2oba6mct46
         DndA==
X-Forwarded-Encrypted: i=1; AJvYcCWZjINZ9ri3gsrHTn6pFHg2kky2WRhtAEn4uJeaUzXPtj6q3dAgisqfBCWkVxbuNdr6unHE88ncSCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvK6AjSymlmPGQza3nWlB61lOhTlxZgNhHscuLSRCS5jdyrrZ
	ZUW8ebzJ3fZOKWxT6AvdNHe1KLDskJkH/ndQ8SfOOOdicZAv24lORQpi65Mt22rTapPVxmIZRwY
	FUERWU/4uvmbBVLT/Le45e64gPI12qhLxi/G7mw==
X-Gm-Gg: ASbGnctWVZjy6jVU4R3+vV6/PzF4ZbpTBW3M5KDUKodjHq0d5J5cGrw1tRm0m4XB8Nw
	mS3EcExTFhGXaZRkvIZb0Dh9u75xIAKESRZadCsjfwR6751uaUXGCJpXYXYRPHpNNE3X1PN05mJ
	1RMF85J4UQRLOoyOM7GxTFEQ==
X-Google-Smtp-Source: AGHT+IGz291D+ba2B23NSZhprn8muxlxhfCK8P3qwCVwnjg64DejVDMET1qWa0V8mNtq0S/w6O4IvzOXyFabUdyweWA=
X-Received: by 2002:a2e:bcce:0:b0:30b:bce7:80da with SMTP id
 38308e7fff4ca-3107c2a5e07mr1935241fa.9.1744755341129; Tue, 15 Apr 2025
 15:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com> <20250409-mdb-max7360-support-v6-8-7a2535876e39@bootlin.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-8-7a2535876e39@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Apr 2025 00:15:30 +0200
X-Gm-Features: ATxdqUHsUTdiuzHDBft1cRFTLonjrdMquqGFbjXe9OBWsOq1Lj_ycSHfvYfu6WU
Message-ID: <CACRpkdbN15ZTeeN2Gj24RC8cB=s8ZqeyOtz9fkPSS1fTgwRKhA@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] gpio: regmap: Allow to provide init_valid_mask callback
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

On Wed, Apr 9, 2025 at 4:56=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:

> Allows to populate the gpio_regmap_config structure with
> init_valid_mask() callback to set on the final gpio_chip structure.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Reviewed-by: Michael Walle <mwalle@kernel.org>

Makes perfect sense!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

