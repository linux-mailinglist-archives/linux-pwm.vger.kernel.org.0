Return-Path: <linux-pwm+bounces-4034-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A669BE022
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79241C22E21
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77631CCED2;
	Wed,  6 Nov 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9TGYqYq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC418FDCE;
	Wed,  6 Nov 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880999; cv=none; b=CASXNz+Q0Q4utIMK23YMnNjEERMNlA69+fgp5k2J4URGffAa3MnTpVWi9Vu8hQEnabpgujigoP31d+EZA3qrWCPT4O2qSNp3QEoiTIrVdjM0oUmE2RgHEYOlbgzqQEky4nGdkgoH87dkt1Uh5myRVjEfhV1/Bo6X8DjxHyBPFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880999; c=relaxed/simple;
	bh=47cL+BYGPWa06/iNmD2zZ/aGmskQxi7SqHCrJfaPG1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NFxmUiFOV5iQX47YhNgNQld7F70SM5wXdi9yfS9MoQJLfG/QB0t2kqFVS6dYiM3e829Plu9uDBqCwczFg+HGM8I0Rrk08W2CnhLeAUqN/7GbPdN02NLB34k/gDnCaL0wyRCNoluaGfZFV4WQ6eI0WBl/LAZe2E3/TD8QBO32EEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9TGYqYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ABDC4CECD;
	Wed,  6 Nov 2024 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730880999;
	bh=47cL+BYGPWa06/iNmD2zZ/aGmskQxi7SqHCrJfaPG1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y9TGYqYq+3i/of8TfoNB+MveH6ytzW2HGQeqkLrss5pFUXCkhr2vnxlgb8jYMtAwN
	 ABbMiRjNKpu8XDK3Xg+GSqcx+n43zalDmBI4fuqszOWEYkqXo/FSEr40plFNQkDJXp
	 pLhTMDQWBEguxTqT1RVx3rhIOWpdVZcI7oG7QzMtedl9OtvGEOP9NS4bSX+mCbWRpi
	 cXszXILIpXEHvg/Ter9JaaD6L6tfHNJLz7Tl9Te0L4d3BG7pVw70h6OF4qxyfT2bJy
	 JUg6oAKmDBJSlz/eYorWPtFwinq7koHHzYobA1z5ohVjgNKdJ/qpOD1hAjiJz02OkN
	 8EKNim7d1DLeQ==
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
In-Reply-To: <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org>
Subject: Re: (subset) [PATCH v9 4/6] dt-bindings: mfd: Add support for
 Airoha EN7581 GPIO System Controller
Message-Id: <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 08:16:35 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 23 Oct 2024 01:20:04 +0200, Lorenzo Bianconi wrote:
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC via
> dedicated pinctrl and pwm child nodes.
> 
> 

Applied, thanks!

[4/6] dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller
      commit: f49f37f3cfe1482d4dc77d26f3e8c38eab630d52

--
Lee Jones [李琼斯]


