Return-Path: <linux-pwm+bounces-7246-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC347B416C0
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151AD1BA2B12
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9302DC329;
	Wed,  3 Sep 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M73gP3w1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4E2D1F5E;
	Wed,  3 Sep 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884912; cv=none; b=EQr0+zlVTpwtPp3hCr1FpiPtKzh3WhdEBHi7Ivl+BJIaQaPZUtMMhVj7cJKOLNWKXn5axSgPwhp7dZ2pDf2/A7lVo+G4nEewdERr7G8Wz9LTePeAxwibvvTsyVUKEmWZrJ0FwGIZMwb8oXZvG2WdXklxTLB6u/TYy+DAZTUce0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884912; c=relaxed/simple;
	bh=8C3xjebS5A1uXK6PAJoBtn+sEHJWk+k90S1IcWEwjIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sta/TAg2uHOFatbp/dOwx29n2sQ6MRF//OFA17n/Mnz0MlapieCq21GSL33bkwzFEUIM4ktebNiJh7MyOp2K7VA41PKDec1Mb+a11Kc69BJw7afiUWxqN7ilS77OzqdQGYS7991rtCp4QivFGlu/W9kpqFIaOvdCil27+Son2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M73gP3w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC3CC4CEF1;
	Wed,  3 Sep 2025 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756884911;
	bh=8C3xjebS5A1uXK6PAJoBtn+sEHJWk+k90S1IcWEwjIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M73gP3w1W942MyxGPW01eX6vsT8OmQh3y23c5PTiaE+RaIv38yilqSRlEaMYQKisS
	 YPdKyJmmD9bnCNvETJSIsXUAZGH52h91XwQkJJQrcgFxmDXzLKckKLQXZALgPEo+OQ
	 nAng21hE2oG2216hOXxbcdI0y9pEaDwXOqhWlNC+GD4JrOm2eFbNv3iSS+QTkv040m
	 6SASxWlOltZNjIwKIOuxAXYvVYg430sLqYlXJ7OFX2KySajblgm3sxfhB/wkncPO9z
	 hdDQmpHAQ0ivmz2DeRoTJuEBxcWr8c0knan/GO3i1Xm5opx5zj19pjPkra2g4EnXYv
	 N0/Naf28FshuA==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Pengyu Luo <mitltlatltl@gmail.com>, Michael Walle <mwalle@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Jean Delvare <jdelvare@suse.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Cheng-Yi Chiang <cychiang@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, Nikita Travkin <nikita@trvn.ru>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mathew McBride <matt@traverse.com.au>
In-Reply-To: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>
References: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3] dt-bindings: mfd: Move embedded
 controllers to own directory
Message-Id: <175688490483.2489808.1034690962892116559.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 08:35:04 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 25 Aug 2025 10:12:02 +0200, Krzysztof Kozlowski wrote:
> Move several embedded controller bindings (like ChromeOS EC, Gateworks
> System Controller and Kontron sl28cpld Board Management) to new
> subdirectory "embedded-controller" matching their purpose.
> 
> An embedded controller (EC) is a discrete component that contains a
> microcontroller (i.e. a small CPU running a small firmware without
> operating system) mounted into a larger computer system running
> a fully fledged operating system that needs to utilize the embedded
> controller as part of its operation.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: Move embedded controllers to own directory
      commit: e19df0d928a7d4a6dda919bb486e1ac2251f384f

--
Lee Jones [李琼斯]


