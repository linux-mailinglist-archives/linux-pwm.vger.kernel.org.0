Return-Path: <linux-pwm+bounces-2337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E4B8FB406
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104641C20FB0
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BE1494DA;
	Tue,  4 Jun 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHq9PdCy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F59148FE3
	for <linux-pwm@vger.kernel.org>; Tue,  4 Jun 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508336; cv=none; b=jTxu+o3w7Kc7cz33y5e+hHXZtE498PENgdslWSrexCQsALbfsX5HijHWq+iS2IDS3T8xjuBKADRQpLv0thwrEZNdYzKWx3JdNtQ9ZiLnu0e4WupOmDpNd8j8Li6FS2s+AYIPwyQ6fU1ipFOMDwg32TwK8fxjRqya0baJ23TBVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508336; c=relaxed/simple;
	bh=+BBeFQRRuSQe7oyiSZua1p7eLPFD+XkIH8GqvQOls00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSAy8CMjbOMzm/WNDvy0iNMbzzQTIZiGbsfEYjVDl3TgVCtsKUIE++rJE4AkelfircAuz8p561uX9qTwBA5BoqqPFjKAlMZsexfN96Vy2WIANIOj61RIEiZBaIoXHLRfEls1MMhxh/e73hAqlux3GhDsxEgB2En0KN9wnw9fEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHq9PdCy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so41730861fa.1
        for <linux-pwm@vger.kernel.org>; Tue, 04 Jun 2024 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717508333; x=1718113133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ24ia6Wzp2Pqb0kKz0O+mmt3fEDNuHDHYJjjdm6g9Y=;
        b=YHq9PdCy9Kc320U8m7DVAAPEDTZJqOBNc2nOUBM0TxxwO3QQOQR3Gib1sfVFezMF1j
         MJiWVCVVz60K7CkMJ3eQCseirht7wUUH4jxYKbQhD9N263xhEetOVyDu9mLhwYw2AQqQ
         Ki2d2PujJtAK2hJpeGAyAb6H77dV8LHB6qWZMuJ/3Y68lCzhE8EjgicICwCnIwlrgCA+
         5+ZnLoYmI6vZZWvSSuFqVB2yMAxj8aY7WmypDiyqtp2JQTISmTNtVARix9d1DnaMzdUT
         yW16uAAmhek466pAjDjbWIKwlmH5UC3Fl+yoidAERiApkkcBmb4u58btbJ3LR/i2/nIi
         /Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508333; x=1718113133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ24ia6Wzp2Pqb0kKz0O+mmt3fEDNuHDHYJjjdm6g9Y=;
        b=Ve4KIiW3nJ92uSV+K4I6Xy5uj6LH9LpCrnxElKr5RjiYuLGeNkvGDMvW668YV/wxJq
         2vIHPyZSqCX5eBbSZhPv4Kv76RZIVMrVZJDI4UiN+ooUbDraH25UuvJK38/5NeI7Tz7b
         hKzorXuuTKJJfCXvrEuS6VQwZCRxNXSQ+a+VrmRuXb1i1CeWJlNXbZjNivmWNxu8iFH+
         OXT4F/vgLCZ1jPmqpZ/RQJixaxlHc7DXfZp+nRa/yADnZnVgstXdcbbRwHjvXfG0GsFl
         QByeDtCvdh9AoL/dw9W5l0pUDkp8qjy/yIUkb62wui3uAijSZOU7Xr+nDf+eiyo/YlYX
         OU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPF9xYY2hGFubSjudPSO4q7aNt3a4IWiBk9+xmayAyAje5Zm8mF9nUt/pxvfBIl6gXh4EJpugyK7E2gQfuyBjz/jlo0atHY5DM
X-Gm-Message-State: AOJu0YzV7FXvOOV90zKl5TYwakyhp4sYQ0pM/ehHeivp77gBGO5Hbgqf
	SKexF6kiqGATYD/tPJBbTu7nWOyjbx0OTv7zM31UYenKZaw9uTPns9H69T/o+ls1SMls4A7CWl8
	olJKKAK4+U5GO/2PybY42wl+2ggvLdLx8aX7ovw==
X-Google-Smtp-Source: AGHT+IELseZkVoEmrnH9ygVfhk2FPI8hjQQ2ghS5fnHMvCo1SZ3J4jQxHmw+jA+8Hu7yKI7d8hScgJSrKdCzuHVgw/s=
X-Received: by 2002:a2e:2401:0:b0:2e6:be3c:9d37 with SMTP id
 38308e7fff4ca-2ea950f70b4mr73997061fa.14.1717508332946; Tue, 04 Jun 2024
 06:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org> <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
In-Reply-To: <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Jun 2024 15:38:41 +0200
Message-ID: <CACRpkdbPGEx9QSazVfP7rbkM7x2MnJbrACdTi3zyniQhZSyTbw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Nicola Di Lieto <nicola.dilieto@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some buzz around the patch made me notice this:

On Sun, Jun 2, 2024 at 10:33=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> +  "#pwm-cells":
> +    const: 3

I guess we should document these three cells:
- First cell must be 0 - just the one PWM on the one GPIO pin
- Second cell should be the default period that can be changed by software
- Third cell is polarity, 0 or PWM_POLARITY_INVERTED

I guess this is 3 not 2 because the maintainers previously said they wanted
it like this? (I haven't read all old mail, nor do I remember...)

The #pwm-cells are currently not properly specified in the bindings: for ex=
ample
pwm-tiecap.yaml says "See pwm.yaml in this directory for a description
of the cells format."
and that file says nothing about the cells and what they are for, should
I send a separate patch for that?

Yours,
Linus Walleij

