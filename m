Return-Path: <linux-pwm+bounces-3964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A379B5577
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 23:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363B7B22400
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126120A5C9;
	Tue, 29 Oct 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoW+GWGq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659152076A3
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239410; cv=none; b=pVMeDMIIzNClXt4nd5ejm0N2iPzAcXbyZQ4KbG+5KnhEKNJYHZzGvxtHzRCbPr9aqiI//JA3eDV3zdL+UtBC+r2e3EgAD5z61kuIqXOGloWm4WAtIwjgAk+U8vKpjFRGrOHdnhb1dCyaWRLWwyuXMVN0lt8dOFf8xiFR85c9j8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239410; c=relaxed/simple;
	bh=2pAo8yXwp7EZT+YMqcaITNqvg6hNd8KJ9Uj2bnSqyIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo6CtYeUO9JinOxro80Hvu0pGPflKJvOfMwpSE+sqEWDvwsxBG0u9FTS86wTdQ12OLDpHBkwairw3Y8iLMNYd9ey+fH/8bMKCKxpfxpk7brRDtVC762s8vW+/7L4QOPffaAAtCTPPrPpZJpeY7pZEVyb169l8AEPmO+aC8eVjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoW+GWGq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso57373851fa.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730239407; x=1730844207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pAo8yXwp7EZT+YMqcaITNqvg6hNd8KJ9Uj2bnSqyIs=;
        b=MoW+GWGqFYb18C38tw767NGzbRWH7mPLNINeizqDuRC1iYBwICoZ4QfVIurrWPclsd
         JNCRZpHd+mw/fjfA1+vcs4BefNK7vBgCPG3ecRoB4W5KMP744EcEq6/rN2ck5YGDLSk8
         KZlUCr0X+o5F+vg1zqHE3n7012CcBvpEJ59RuGb1R4xK8maLJGQcDc2OUNnaBCrQdxay
         YqFbvri7MJ1OEaYi45IgM53jTIlYOZz8uSA065IwKqGERX5fTsc1oaOEH/YZ4qMGXDHW
         LtmdL2WyrqrTks5fkwLOO2Fio9zAFoQETN2YcXgIMrrPrG6ixiR7ZApvOiF64y+WUhnZ
         LoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730239407; x=1730844207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pAo8yXwp7EZT+YMqcaITNqvg6hNd8KJ9Uj2bnSqyIs=;
        b=gnczL6tzmo2CrikYmgHCcQpwz13M018SRQ1ExvUW6xDjU+Fx+zjj6mjCSO8IFcnFQl
         TnXyTdxH3fU32Rk++M6ci8pBTh4vAgejPDzw1B2Hdomd4D/0ool/skMhOmscvY1Je28R
         yiVknGENf3bcMS2PyFvaqUU8jvczTeW5dVuS4BZwDBLqoa0f0sKSgbV7PLFlTEFoxW09
         ++3JNaueG/angvxUhoYwd3gHDGEyFJR7QQjO7PdQ971Y+/MgBUVMieVw1whfsT073o96
         /Iqc3PZGIkaLvBHb91KSLUqHsxJg9XDUJslTt+WYJ/bpEglcJBarpeU53fAywvu30xGw
         Ccqw==
X-Forwarded-Encrypted: i=1; AJvYcCVCw0Sfet3F2/bSb7dlSbnIfQmGMdG7YCbePd6nSQfEO5aDabZcxvXSjAdU2jya+2zF31PP0opb8EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4TteysQ/T+DVuihAbPL8DrOX/wQUwDLr1GQc9cCO/49Bdi3O
	2S65o9hTTBcEzrDkGjW3HWBjs9DmB5/PuIKwUmJW7vKwls2Ta/jrKtmXs59chY4vXYnpKaWvT3r
	gGOnfWmhK8oGtHzr7jPET7GYnPeWEAmKRl2Gp5w==
X-Google-Smtp-Source: AGHT+IGcZQz6tTz7pENhFcPJcjvryEeZRAirjIXuUi7C7dPCymNJLcuzkHhPfZv22aI+RYtsi5iRg8Bn14ptPLiFVos=
X-Received: by 2002:a2e:be9f:0:b0:2fb:3bef:6233 with SMTP id
 38308e7fff4ca-2fcbe08cf3bmr61215001fa.33.1730239406513; Tue, 29 Oct 2024
 15:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
In-Reply-To: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 23:03:14 +0100
Message-ID: <CACRpkdaEQYBim8TuDCCw15QDUWhHC-VqhGq1Le7eOd76k56zwQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
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

On Wed, Oct 23, 2024 at 1:21=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:

> Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
> EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> needs to access the same memory block (gpio memory region) to configure
> {gio,irq}_chip and pwm functionalities respectively, so model them as
> childs of a parent mfd driver.

OK someone has to merge this and I suggest that I merge patches 1-5
(all bindings and the pinctrl driver) since the different bindings have
dependencies between them.

Then Uwe can merge patch 6/6 (the pwm driver).

Anyone against?

Yours,
Linus Walleij

