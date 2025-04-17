Return-Path: <linux-pwm+bounces-5557-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F631A91C37
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD120446D22
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE1245022;
	Thu, 17 Apr 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oH/r7LEs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34D2405F6
	for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892952; cv=none; b=sTbo++DdDfg2tqv0ngZGm/nDSrTWT7PMDHH5TEyfBm8x5shzFYfSEePlWX8MVEQrXMb3fkWt4mzI3E4pP/LZ2J3+UARByqBfp8l/ldDJlbxkwYVQqWDlaEfM8r77/rmIqUDsoCPeUlqJHPg+WZJB1jh35KgkQqKMXpKXBxAv1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892952; c=relaxed/simple;
	bh=nu6kbIacrpDCT5vMw5ES0U54Qb9pSv7ZCfuS9blSr08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSZ1BI4sUffet5YW3EsXvkHyGpJtNdCbg77LrJwIMDrcGos+BBLDuAVKBWshpBsGJ7gLqHL+pZpuo7WCS7K6I7WJ6K/7t6/H5ZAsgftD0gyd+2FlcXwA82sXRnCAKhobdNw9F3ipg7hq7mzCTq3WBVSPaISTg0oZCa6LDF+oHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oH/r7LEs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54af20849adso757637e87.1
        for <linux-pwm@vger.kernel.org>; Thu, 17 Apr 2025 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744892948; x=1745497748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu6kbIacrpDCT5vMw5ES0U54Qb9pSv7ZCfuS9blSr08=;
        b=oH/r7LEsFoAz0i1pw1RFw6ScprK94yEpx7iis+HM63ZVWEVzko9AU1wMLopqzg+fAb
         DgQbDu4mQqxtRMnbFJqlg8Ip32xKqv7nULaSedKbmcfxViynuRJsYRXXPTaQlUYTlUNI
         w6HGaaOIh1KB4ikcg04yvIgX4nEMfa8ZQm+imUBibn3w+Wvdec+nM+93CHI/KXiOQdfv
         wakzn+USbfO7rHxmJan9gG4mvfPVKoFpt65JWR3pjQbcF0jtSiwC0En55FJs9xZFRodM
         7HwvfHqsvyFmZsYLg+hqLJmWOE90DQDzt9+GmDEglO8P/EN6Pp6ss4l3A9Ohskpit50q
         Gk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892948; x=1745497748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nu6kbIacrpDCT5vMw5ES0U54Qb9pSv7ZCfuS9blSr08=;
        b=mcpuMRzjiXCE0gwmm5/9Yq+2Py3nHwdni0XCjQvAxfeGR7MXFXVubmpaP6JiUNX11h
         lfVEmYuNaT0jHipbpodKLwmr7L9Aks+b1Jb8HyMpBj1J/Hhh5gvBe5jg3OJYsEN7nK9Q
         LVjyVRcESucduo6bAd6cjnyabVPz7lLRt2Gv2EcG8GWtkcoKfCrmaHqGOTM3SYygKNhd
         WHLzuM9C+XTQBrhaR22Pr5KpYose/0rNfALoF0yHKT9v9ovwZKH0TgKkqyMBYr2T/RjM
         fKZRXBDchSEr9FRhuJ3o3CXWJv0viJWSz253ZP2b2Ys31gklSofGSRE9p6CSAw6VcKGe
         /4mA==
X-Forwarded-Encrypted: i=1; AJvYcCWul37aeUVo22EMMZV7B3aJcQl15KApzd+MpDVEgXTPmmlToTOzipGriWphmoPTp9uYRZoK6JfkfJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKhlMYynDNoxacZOJY5fbPMCWAWhL/rCIkxt42kvphI9QtlYv
	UeVZtVcJ/talARHsimQw/AFnKo0/D7QUEPcyReXfZRyRK1vCrm2SXjbQPXKCXB+Q0LRyZm39K7G
	fkNXIarX6SEehQdUXQsYDOhzUrgGBQnkIQdU0Eg==
X-Gm-Gg: ASbGncvGzj/gL/aXZ7i8FUp0CNUFP019Ra2tnI5m5VXr0xox7G0Y37QOwt9uZ18Zhl6
	Uwh/S9o+Fjf+Umrm/3K3RJxuwC9AY5yq8y3LDvH2n3VIsTcuFafpRRsP2XsTrA0W5lhk4rZgICm
	8KzySD5iBj57R/vCK6W0kbtuQbtK/wwd/61zLcrwDzx/aaLQfibPmAQ5I=
X-Google-Smtp-Source: AGHT+IEF+h77GIjECx++dvbLtSxZcrgUv4As1K7LTL0wGasowDO/DAHV6mNaDlM5AhBuOyn8iTjUFe/V1V2STZoogO4=
X-Received: by 2002:a05:6512:3056:b0:545:4ca:d395 with SMTP id
 2adb3069b0e04-54d69b4d325mr703862e87.2.1744892947916; Thu, 17 Apr 2025
 05:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com> <20250415-dev-adp5589-fw-v2-11-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-11-3a799c3ed812@analog.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Apr 2025 14:28:56 +0200
X-Gm-Features: ATxdqUEjG3srjaR1zbdJGVx0d1VvANk4hPBYsb6-d9hZ0St9SHLUzFXCFtyNaIE
Message-ID: <CAMRc=Meu8KK6s=DUs-4N9FwD8n1diPo6zvgzG_XKB_kg=7Pfuw@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] gpio: adp5585: support gpi events
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:49=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Add support for adding GPIs to the event FIFO. This is done by adding
> irq_chip support. Like this, one can use the input gpio_keys driver as a
> "frontend" device and input handler.
>
> As part of this change, we now implement .init_valid_mask() as we can't
> blindly consume all available pins as GPIOs (example: some pins can be
> used for forming a keymap matrix).
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

