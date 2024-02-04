Return-Path: <linux-pwm+bounces-1200-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE923849120
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 23:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9776A282990
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 22:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B87460;
	Sun,  4 Feb 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jt3NFkWJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BCBA27
	for <linux-pwm@vger.kernel.org>; Sun,  4 Feb 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707086889; cv=none; b=R3PqQNIv5cnx+vtjzBvSGmKFxMEYfAI0LyO6onjcfCCGqW6AhCR5DXFc7Kynxipr5JvPoKfyk98qLlNXLPe0Zh9fLtfHWoVQWi6NXoHmSiJ+Zwh4YS37zjdNcd76R8177eQJuDjJVtBxLoBH2ur2RAKKSmDCWjjFJFxGjEP5lgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707086889; c=relaxed/simple;
	bh=kD6KAqTBArB2SIqT/Vwa+OJYFmHJmT6pAMJN7lY/K7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwqe35kBnqQUD0bN/vhmdQKInmfA/MYQRYVJ9UYHRncW9/Jg5vj8+1x0A//pcE6T2+4A7ZIcaWZPboGqiDGaXYcueFyzAL5CE7gANNIdwTLH5Sb7Wz2y8jCB2OMAeSUzsuRVI5eCmGwXcz3e98PdrXyH8pW+tUsrf6fbHK2+6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jt3NFkWJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6040a879e1eso39920717b3.3
        for <linux-pwm@vger.kernel.org>; Sun, 04 Feb 2024 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707086886; x=1707691686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD6KAqTBArB2SIqT/Vwa+OJYFmHJmT6pAMJN7lY/K7I=;
        b=Jt3NFkWJTwPAWRW2YUXKhx0d2Bxl03kN7mLsBSni4gxx1VHCcQR+ihhY9HavHUg4qo
         /uxYqC2rsTau8PybccPuixOfw2Xw8SqWm6bDsUupkEOZcvlTz/oBgc9mALxAQrxNXg5q
         5VzOySTeIWjvqHeyLMHxoBWoczZ0xhVia+9KbQ9itW7taAXWAK6ELIWuaesYIfKFGxW7
         YYV8N8fpPoLtZIvLcCc8Gkd+UHQmpHnQHeM4dZvXxiEZooOHEfdK61ZO69qW/1OBfD6s
         g1vqw6SNsSjL61uhcDPxhuRVX8EhglrrRdARp3hYRkMQk5rNMpvK6AL+MDGGByFddHun
         RIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707086886; x=1707691686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD6KAqTBArB2SIqT/Vwa+OJYFmHJmT6pAMJN7lY/K7I=;
        b=bkKkMPFgy+0smYatyokbkgb5fWXCXY665FqrW1Kwrfz4zrZF1JOw9tpbfHSxg/p3dm
         a2C0lNn0z3QN30OOGP9lvMNy7mdF2KqRHrUH3c3YJJgc7tpzHT+N3FczX4dVgW7+uthA
         QQxnJrsP9/ZkIPs5l87abrHiegzfocLtI8fXb6BWNWzGrjuRnmKbFAI4AxpE4pGJNtG9
         t+kfw85RNMAEsjDrwVwAO8tJQeUY12InqrzJFFzene6ZAh2U/eopi/XO14a3v13n7J+4
         G3tLBvPWoq+C1K5CDAAZymoAYAg9U36sNu8Q3+TSREcko7M5swkAoScE29kuTAhpfviG
         718g==
X-Gm-Message-State: AOJu0YxToIZ1Vnt7qN40PHHpit7OnOfx7m3CarkuA3NeXzdxOclyuQ4d
	pRAVVgN+gXzvYdEw2tsjATQTVoIzpZsGDvt/OAvNO1T8KfUjwFICkTpYJD5J6ncf6YIBoFjqxWY
	7ohadNaUhIgqDa2WTbc8CK9jDfFD8bSGmZGJbHg==
X-Google-Smtp-Source: AGHT+IHRgzJB6CueGHeivyFsdKulZLOKYp4MBw07acceiUDs+aIfWuO1UqeXXr2XEiqME7pqYmnX4ATtGQg/lGlPcew=
X-Received: by 2002:a0d:d611:0:b0:604:e15:81a with SMTP id y17-20020a0dd611000000b006040e15081amr12206726ywd.52.1707086886066;
 Sun, 04 Feb 2024 14:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204220851.4783-1-wahrenst@gmx.net> <20240204220851.4783-2-wahrenst@gmx.net>
In-Reply-To: <20240204220851.4783-2-wahrenst@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Feb 2024 23:47:54 +0100
Message-ID: <CACRpkdZvG4hU+7Etu+1sfiSHoeypX0kiwrot5x8bOxkw+oWP9A@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: pwm: Add pwm-gpio
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Nicola Di Lieto <nicola.dilieto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:09=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:

> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
>
> Add bindings for PWM modulated by GPIO.
>
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

