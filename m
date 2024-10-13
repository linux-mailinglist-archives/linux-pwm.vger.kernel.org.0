Return-Path: <linux-pwm+bounces-3623-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214999BBE7
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Oct 2024 23:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF01B20D3C
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Oct 2024 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8514A4D1;
	Sun, 13 Oct 2024 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEv5d3ww"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913E148314
	for <linux-pwm@vger.kernel.org>; Sun, 13 Oct 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853426; cv=none; b=hBH8pUEND3n35TPCDKq2k3816tqJ4zWguoMhWk3UWJ7UaJw9f3juBIEajCFXnaKA8YM6mJrtPa9ZhiXt3pVOgblsyWtnccNzUZCsk/fWB89hUDIrrStipEpZD4dBscA8Mxk9wHJIAEGxhrr7Qwio5qmybr17L6BBeR2IrzYOJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853426; c=relaxed/simple;
	bh=FLf9Ev/wQgipDcZlw83jwm5kLXK/zBmwzvq/PiQYMQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPfdwD7S1kaWjQPnIDAVJ6BnE02cbLDzob/3uxslUIQG6OrTX3Hke9rCLr/yQ//ShnKszuF8paoOb9pZwn16R85FVmbB6bSHnCaABD4Uw3vAO9Ux3koBIk3AF1ss0P7V9NJTG1ZEyOlNsO+EaBRLwax8jhoSEqSpgLMW1plM2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MEv5d3ww; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so509746e87.1
        for <linux-pwm@vger.kernel.org>; Sun, 13 Oct 2024 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728853423; x=1729458223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLf9Ev/wQgipDcZlw83jwm5kLXK/zBmwzvq/PiQYMQI=;
        b=MEv5d3wwVIUqTbl2pHpmtwr7hFhF83mPwrxJ1OxG9YdnGSzLcagjdDnCwAqJPknC+B
         MtQZUGk5qEmV/YbRej+enym7WPFvOnp3Gp8Nn1HGDLmk11m8hcsW9/s9y54UQ5PbiYXp
         mVAlVJ3Fn7myC0zTKaepZhXiOFgx7FeAthEW5+Bx82OvK1mwymB9jXPdBywtiuC2FirN
         Z2WnWcF44sfWr/hqPWiHoxDBiS5OBMqpzVPZdXjziP9ulf5ViKrXl+e6V69ImXA65uj5
         7GnsquMF/mlKjItiexlU9eO+MqP5FMTzyEE0FF6x4M3pa4JwG5as8kYqEfFNey2JYHAG
         7H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728853423; x=1729458223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLf9Ev/wQgipDcZlw83jwm5kLXK/zBmwzvq/PiQYMQI=;
        b=sw99BTDeZpscGsm43JK5vCmzfr0Vgwm52cshRiGSB7E4AM+449wgCFYsyV2GlGq1lk
         lIUY5mlG8lhNb/7jAjW3v1qFbUgm7uBwnP8ver9bJVB9i4bbiOgZFKizPjZme9MYSWDs
         qVGQcthGOr+YmGUohtmUeN+efDU9NEChhkPNUCr9vHY4mgF+k7yFZAmcx6Hb3Ynnh2x/
         s8JKDwXnGV0On2WNzVbp87KQRhIndtKKzgV+Fi0ooLIZcswlY0XiOq9Zdafp8sSn8wHo
         eIC95mw2iPP2j7fFV9LBOFVH8qDfwEokTFbQDIXUkU4qHKaqSZbD1pR6ngocw+SXJEJF
         rhrA==
X-Forwarded-Encrypted: i=1; AJvYcCXebe9cq65UZGJMiI55HztNNKYBZofS5FX59MSDDnsUTFaYA9xTE+xeLM3eCIcAdAmDCK+L5O4PVbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI++eunoPF/9OyGCw7qEV2DaJnogBYF1cP+9SVe3jrxK44v2Kc
	trnA07gJr+9DtcYIq3Ycph4Nd9/1xcbLmX2Yi/Rbok0NC7lX6DFVP1dVE1KdgJX1VVkQOG3Tx4e
	f/MlImlxIWVtYnDB0jjlwjNlJvY8/J7MVDCohcg==
X-Google-Smtp-Source: AGHT+IFa3Un5SUZOY+WLd4u8uuT8jEO8T34DA1v0bhROVGdMNVLjn6uobn3EByZ64OPzccOgb3Fhg81/qWo8P87tPkk=
X-Received: by 2002:a05:6512:1193:b0:539:e65a:8a7c with SMTP id
 2adb3069b0e04-539e65a8b8emr1533379e87.58.1728853422775; Sun, 13 Oct 2024
 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org> <20241013-en7581-pinctrl-v6-4-2048e2d099c2@kernel.org>
In-Reply-To: <20241013-en7581-pinctrl-v6-4-2048e2d099c2@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 13 Oct 2024 23:03:31 +0200
Message-ID: <CACRpkdbCBJVQsSwYJPBpjbpNvxUportnxxKObb-cYjqcSTpOFg@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 12:08=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:

> From: Christian Marangi <ansuelsmth@gmail.com>
>
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC via
> dedicated pinctrl and pwm child nodes.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

LGTM!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

