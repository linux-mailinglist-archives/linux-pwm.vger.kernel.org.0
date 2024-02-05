Return-Path: <linux-pwm+bounces-1209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C579849567
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 09:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4C3286F19
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090611CB6;
	Mon,  5 Feb 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e55rxr8b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445311CA9
	for <linux-pwm@vger.kernel.org>; Mon,  5 Feb 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121807; cv=none; b=QXT8VmRrdmIbqn8ArBVizRaGeHTFRuucOI213qUk7t6ZPknqnn4Ug7UmBMI4bmnCmlcuvvdaNlhgKvzkl8Gb7sOyvaHRTvP1yVdZj5L/gDK7Ovh63ukUADp3tbSoo7Yop5njowU736A3GCA9hPmgOxyjVglcJOEwvs4lVcd4+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121807; c=relaxed/simple;
	bh=5E/cFiwqOCZ9yUiByP4NeDdn4JVgIuGTviECou6d5Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONSQqnqMgPLXaUDTwHNXTiN2fWnXhLLAVvFclEO94oV8hEPdFlwZaVZlyICpXSBsX/J5rIyvy8D/RPInBHs2WkhlS4dGezdVdYRh8hE37CstEPT7xQ2fFxUdN66ldxCj5/kwmceftiMU+4PbXenANvmTTyYoyqPwna+FsE7OPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e55rxr8b; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso1706077241.2
        for <linux-pwm@vger.kernel.org>; Mon, 05 Feb 2024 00:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707121803; x=1707726603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP1MQXgFQfsBDnq3C99i1upab9U4vtCS4F3n/q5yC7o=;
        b=e55rxr8bpkYmNX5VlELcX4DuOouI5jaxHhIRfEd4g+H9Mn5Lc2KQGw659M+/Nh3peW
         TlyggK+y2C9BYfHgkHKiXdJVvR6xt8RoU/DFfMZmow+uuWHBI7mM4mBPjPen2qmOhwPB
         aPIYnCylCQBJV9WtQZr1QxqlrWnarUA0VRQJTErKmmeTcsOBR5HJUEdSL9qtAopeVhC9
         33Ul2FKj6DcQCT0fDr1b03+J4Tqnq9EOPXsr6D0S0XTg298o+7th4QOhJzCxnYWEUkw8
         +MT2S1aYUgkKXYEECWO0RG/eLMoCJojxZvvWo1PTHeU9g4fyJFNWwXb9gMwLKK6EZJ9N
         XggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707121803; x=1707726603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP1MQXgFQfsBDnq3C99i1upab9U4vtCS4F3n/q5yC7o=;
        b=IdArPLjNWuO6BhFG9zLlr7PL4FFU6pj+O/v6CDOshFE5LO0Cn+fnR78YlFyR53Tuwh
         loO7FFOx5T0Uw4sc3qAwpySD2X2fcjnWuk8FHDAu3BTfBdO9uMKYtzQh+YFFIh2BO9Ve
         ta2D7XT7eU5mIE1McNtB4YEKYgCvO6l0tZBdJrnAptRuxx06qSYeXKBtuQIRFMNo8Wfr
         F8eDR2k+T3iqhtYthNhZmF5YY5CF8J26YYDitBeEsvbu3DpGX51ZkqJMBdg4VtWI7EGT
         qcqRa+vXHVqvctL/KFR7rWD6IEypZ8zjZkND/GXuk3IBWDANZI3FMexyaduBM4WOSg+x
         iG3A==
X-Gm-Message-State: AOJu0Yy6p6OLPtJYlqUBwam62l8ugFsti2YI06/Xe9ZP/HnOQDifH+Tm
	jLm7QG2s4CN+6F2dmlUqBvTPUOLZCtWKoF1R8xOK4rGM3ziq8xSLn8unowZi4WCIdBJ6z8sMCqK
	PPsktqrkByAoESciQ7Y3U/l1Q5IuQOOkugikCvg==
X-Google-Smtp-Source: AGHT+IESqMdtN25YAJIeP1o5PEI4DSSRQhHcQveOW5MKwjv+mmFybW5orSDKVPvh4NjAySqx2ayaD7WpVbDnOaaJlKc=
X-Received: by 2002:a05:6102:3208:b0:46d:2719:7a8d with SMTP id
 r8-20020a056102320800b0046d27197a8dmr941872vsf.6.1707121802904; Mon, 05 Feb
 2024 00:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202222352.1652745-1-robh@kernel.org>
In-Reply-To: <20240202222352.1652745-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 09:29:51 +0100
Message-ID: <CAMRc=Mf0ohQ4Cav2wSDOHydhrSDm8fiL+cjv4hR0m7=8UBDkUw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: mvebu: Fix "unevaluatedProperties" to
 be false
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> Schemas need "unevaluatedProperties" or "additionalProperties" to be
> false in order to disallow undefined properties. Only common or
> otherwise incomplete schemas should allow undefined properties.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> index f1bd1e6b2e1f..33d4e4716516 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> @@ -115,7 +115,7 @@ allOf:
>        required:
>          - reg
>
> -unevaluatedProperties: true
> +unevaluatedProperties: false
>
>  examples:
>    - |
> --
> 2.43.0
>

Applied, thanks!

Bart

