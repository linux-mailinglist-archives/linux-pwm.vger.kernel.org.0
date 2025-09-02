Return-Path: <linux-pwm+bounces-7239-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F9B40832
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2920E3A6B3F
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78BE31CA6D;
	Tue,  2 Sep 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SToTgVjr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8072AD31;
	Tue,  2 Sep 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824806; cv=none; b=M7oPXylrXVqXfwIsiV+j/V6NsFjJkkEdvDkrvQfGSvYEiussqaZ+eblLS2Gf+hQk5Xphp9S8CJ4rDJHIQSBU9HP1DPPHtGsDtENlEWvaS8lUX1mCv5lGcCoBhlCYpj5sqq7emywIGSs38Njsq/5TK45AtO/BbVGuTMCopk7wWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824806; c=relaxed/simple;
	bh=XnhcKQ0mTkSa95MOF/2v+K0wcVMZn/6UjuPiVArQAKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=olP63A331GOQAC44BEpyLh6K4thWYEWs5JQZ143M+dbUgIlNDbtfiQNyycnOontdZedhlPYi0f8tCoPei2sp/zEd4fU1AL84tRhPFZjxW6nPPKk/w+U7KK9ZeZoQ0AzTnewCmFlkycgfcMmqE1HVq9ZiHWPam75lzDisZVeujQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SToTgVjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74C5C4CEED;
	Tue,  2 Sep 2025 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824806;
	bh=XnhcKQ0mTkSa95MOF/2v+K0wcVMZn/6UjuPiVArQAKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SToTgVjrXqpeIG5fNWQnsstKIvgYyXo66TBdSFk1+j1lZ4+6CEqhAtSwW8YZGziWW
	 D9j3rYf3FuJT7iD3f1r6Bc/JT0xAlEWsA3wFrdA7e+pgwtcmdqLVlWOPuwfbRJpyaF
	 id9Dw3cN0/Jc7ipglKjh5XomTQAThPiKCl4rgenoL3KWyVLlcYfa6oDJwpCgwQ66My
	 R0Qno13zTf9GEXGaOh0DJECFJhGJJoOpjF+EOzpbkPbwnbRXJ3VmnxsHEyyJjPOTA3
	 IHpfB5oR0vbqT7jLHly7W/wPoqM8iKVyQlpe+5j4yOrVhVREimKyjavu1pooRiOQ8L
	 +75gzhzKGINAA==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Michael Walle <mwalle@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Jean Delvare <jdelvare@suse.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Cheng-Yi Chiang <cychiang@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>, devicetree@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mathew McBride <matt@traverse.com.au>
In-Reply-To: <20250822075712.27314-2-krzysztof.kozlowski@linaro.org>
References: <20250822075712.27314-2-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: Move embedded
 controllers to own directory
Message-Id: <175682479961.2401991.17056649550187344851.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:53:19 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 22 Aug 2025 09:57:13 +0200, Krzysztof Kozlowski wrote:
> Move ChromeOS Embedded Controller, Gateworks System Controller and
> Kontron sl28cpld Board Management Controller to new subdirectory
> "embedded-controller" matching their purpose.  MFD is coming from Linux
> and does not really fit the actual purpose of this hardware.
> 
> Rename Gateworks GSC filename to match compatible, as preferred for
> bindings.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: Move embedded controllers to own directory
      commit: 152afab28f7659a4292c9f7d3324eaeb49a55b8b

--
Lee Jones [李琼斯]


