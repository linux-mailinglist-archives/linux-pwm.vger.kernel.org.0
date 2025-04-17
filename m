Return-Path: <linux-pwm+bounces-5558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D60A91C90
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 14:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF775A656B
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92257242923;
	Thu, 17 Apr 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g42nueKz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098E3770B
	for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893711; cv=none; b=PSJxVU3tgw4lu0ZEYsu56VufKP5LRDY9vGyZaW2ijtP/d3ogFxgufnjQdJZ3rPFrxel4cxJXRAHtIrhfzogTSCuZrlPRG5xN4G9CD4Y3/WXppjgqtQamuTSrh8ZMPAuIeR2rXWDhDxhdIJpzv/RMMOAjUShVOpSXBwbmMZVa7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893711; c=relaxed/simple;
	bh=nQIIrU067YTPjOc8LmZh4/vPjF2wg8asBmSLf3GZb2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kvee42ma+MzCZxI/qYnl1MJ0lSfnusSPfo1AbhY7VloeKgwlPhVoP6sQqXwW5q2qyUhdBJmja/52o1Bqa3ckhIiW0LRosH1M/OnhYPWOjXzOrnSWDti4CwUGQyLZGfexeRcaoUZ/QVj4z+6mQiRFL+fZ0csARGBMVqnQ1kJQzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g42nueKz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54c090fc7adso815369e87.2
        for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744893708; x=1745498508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ5lyKYfN+K0uYV9se5bx7j4N0g/Y1mbf+XUFGCcm+I=;
        b=g42nueKzZ04eVy6vvZmlMsoemoK8Hj/WzbiclabKX+DVq23/NEUMdXtZ9Td/5lkqy8
         RSA+kXAClrcSFInJCXyLPz44r8/WmmaW5eT0MU3682gv2zhITYNPgmkSwnC2GDQ/QCWf
         lf/EJyozmkFYDa0gyInvRi7wSzVHXll+UUOWKO+QZ1nl4vtFLfwm9b4/CCpMP+wvUfJ5
         qtupkr6jGWpGDBePjwPsKOL5NzXrbgUeQYgZUiylvrtN9MS/0oB7UxP/2FqYrhSZuI8I
         Yeo6tWuzs0nne1XOHSBEqFQpjthZlh7ZLPfKOs+qVaVxfW2LsbLnV1qUR/zdk5mrBNHG
         6VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893708; x=1745498508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ5lyKYfN+K0uYV9se5bx7j4N0g/Y1mbf+XUFGCcm+I=;
        b=rEF21LnlkEuF9l5Km9cj4yoiqr3Q76mLRnQPFRi4EKbpb5D9THC7w9LwfoO4SKFF44
         /mXpwDPFfv9DQ5BhJbTZPAvWe2do5Ul6AF+/joqEZpC++ARquZnPiG8P6OcWoPviGVVF
         W9ablT7L+eFpJpJNpM0O49VKy4Kxal5tfdegDqSHU5P0LHTYjpgCrF5izyObhUhvJ7x4
         UBk6hSIuaNKybsI+wO4obhdb4IWqOX8dbMub89sTI1cl9pGIwUePGQ5JSb6jGsNSfIhl
         DWsWenYbUALkWUzTRqDMrfTNwBy9Jz8JnU4zDaeArl0l99fr/5xtnzwQ/mgsE3MXiyQg
         N0jA==
X-Forwarded-Encrypted: i=1; AJvYcCWCYsqHZBWRDhVbCEgRTcJY4KJZ5X6CrM7h81FpyT9bXRrUNlpz5q86n3xkhNoYR4tErff3ukkxBr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7f8ZGUDO+Xd7X8TFNMxoH63zkSXUSqGjZhX2ml5N3hH5v0r5
	7STGpIZtyljxCzQIPsdn5Hu+4U1KCv2fHeoMtJlT0wJ1QeOu9D9YaEm5KK2N++MNA3QMGJjGA0R
	xfDLxx5zP82UJcJkySABvFgx9omJ/rYElFUpeiQ==
X-Gm-Gg: ASbGncvJAGlGseAxQqOw4ojlR44po5GMtBm5VlA8tWtaSihMpuPpPkYmEOPdeuPNUjl
	Qjrwkhuo5+FACcfcJbWlUVe9e8Dsp06Vt0Y0GnhXiPyb2lpPMWuZS/ML8FD3hvUEPcQngAu9elo
	FzLut4LlCgzYTb1vgk4wtYHDP8Ozz9XFckokMMS1X7K6/EOIgn5wDJgps=
X-Google-Smtp-Source: AGHT+IGCeVLIonXAZLoZuX26dLN3o/5NzBTerYwwXcLsLxVnsPGKrq48ijHC2fwB40UH+JZf3EjGuDJ2/FAZWXTNCFQ=
X-Received: by 2002:a05:6512:3d0d:b0:545:1082:91a1 with SMTP id
 2adb3069b0e04-54d64a7b6f0mr1692690e87.7.1744893707675; Thu, 17 Apr 2025
 05:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com> <20250409-mdb-max7360-support-v6-9-7a2535876e39@bootlin.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-9-7a2535876e39@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Apr 2025 14:41:36 +0200
X-Gm-Features: ATxdqUHVnRgKXXdU0felXL5SR5G-r5Je-4YU4gveufkl7eBQ6Hnf24ePYuscRak
Message-ID: <CAMRc=MdKswkm2jzok6Uw3cG6uDkVq+CMXbJgP3fRY+jHo+rPkQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] gpio: max7360: Add MAX7360 gpio support
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
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
>
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.
>
> Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Looks good to me.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

