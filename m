Return-Path: <linux-pwm+bounces-7594-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75270C36FB4
	for <lists+linux-pwm@lfdr.de>; Wed, 05 Nov 2025 18:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492651A27E31
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Nov 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A233C50D;
	Wed,  5 Nov 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQGTUh2j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792D337115;
	Wed,  5 Nov 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361944; cv=none; b=VpTj8ewDoPOelevY+VvIfm8yMRlmN5e6J/mYpRwzwE/+qy39/p2nzO6DNcYUjScD6SuAKGjpPCdqwjXXSS1+LYNSoWPDew2ZjApQPwjdDWPNcDc9eyfpX+x6jmcbelo+fw3TN83vttHgnX7UEKzRqw5hwNsaHGDRejDcj4rSOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361944; c=relaxed/simple;
	bh=1J87xzk9VW3lpoQ+hkZnGeccC3K0L5gdz2AKUwHegLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FlxeGOvSqkVrmM83fAZtZ9NQUPi8yLgJSXMPLjAG66EDfkcw8nloXg8E/iskdtggsKnzJJBBLNzQ50wyNBtwMBPqwWH5EOVb4IGv7/BtjK9QNoFYSkGpYqIud6R/NYI0Pl8FRVp/Std55uW/KK891qeSedx/gUNgaVNa7y6Iqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQGTUh2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCDCC4CEF8;
	Wed,  5 Nov 2025 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361943;
	bh=1J87xzk9VW3lpoQ+hkZnGeccC3K0L5gdz2AKUwHegLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CQGTUh2juHjQ0qGUIJYSwANSA+HsCyK5E2ANQOb6XSJwLMqQtKobX/k4eSLUgrnrv
	 cRqV/j6qaJEaBvihDxBZ9DTHbT4Xx6CIkG2i13JVfNiatzPdQu94ogqOT2c24kiwMF
	 S7os2yloZfSuw+1CiKojJ722oHNUK+W2jpyliDw4xDcPBkjXcJ5QH5DAdU0XEPb9HL
	 9cuSV/NzXN0RGN+z+sClJ9QkwHj6Ga0JcvLzGCoxXY752HSwBN1Du17A09MOoP8u86
	 b0zZOGlB7UESmENdd2M67Z16PulHQrTGoNQjYqi49I1fR8g8CiOQJkN3J1AJM4yKPa
	 Vk9T2qwFrJ+tQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, ukleinek@kernel.org, 
 gregkh@linuxfoundation.org, jirislaby@kernel.org, daniel.lezcano@linaro.org, 
 tglx@linutronix.de, chunfeng.yun@mediatek.com, wim@linux-watchdog.org, 
 linux@roeck-us.net, sean.wang@mediatek.com, zhiyong.tao@mediatek.com, 
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, jitao.shi@mediatek.com, 
 Jack Hsu <jh.hsu@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20251030134541.784011-1-jh.hsu@mediatek.com>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
Subject: Re: (subset) [PATCH v6 00/11] Add mt8189 dts evaluation board and
 Makefile
Message-Id: <176236193629.37589.12615931533548308117.b4-ty@kernel.org>
Date: Wed, 05 Nov 2025 16:58:56 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 30 Oct 2025 21:44:32 +0800, Jack Hsu wrote:
> In this patch series,
> we add Mediatek MT8189 evaluation board dts, dtsi and Makefile,
> and also related dt-binding documents.
> 
> based on tag: next-20251029
> 
> Note:
> This patch series depends on following dt-binding headers and yamls
> 1.dt-binding headers
>   1. mt8189-pinfunc.h
>        https://patchwork.kernel.org/project/linux-mediatek/patch/20250919020525.7904-1-ot_cathy.xu@mediatek.com/
>   2. mt8189_gce.h
>        https://patchwork.kernel.org/project/linux-mediatek/patch/20250820093831.23437-3-xiandong.wang@mediatek.com/
> 
> [...]

Applied, thanks!

[03/11] dt-bindings: nvmem: Support MediaTek MT8189 evb board efuse
        commit: 2150cd7ffd14a39fb56c2b3cbfcc6dbf629b7643

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


