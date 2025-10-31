Return-Path: <linux-pwm+bounces-7570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66673C23CA8
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5103A5E72
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25A2C029A;
	Fri, 31 Oct 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9B5iD6S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B3253957;
	Fri, 31 Oct 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898741; cv=none; b=GTqH21C/Xun4zcrzpq4qtm6vR3trqmOmdxsYUrK0PLpNGZ68F1hUe2ZO84+T3exyYON5s1EMVY6+hS/nxAqWS6ayAAKxWJ3LzaXouh8JbcRMjq2Q7bHzxPK02Erjq6MRliskyK7DtDfbca5oqfgnO0GeT2gBSHWaz4ahuGbM4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898741; c=relaxed/simple;
	bh=AGxEpfdFzeMPLbbU8OvwzY2XUqW8zSz0RQQyFpRG6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU5xRb1yGMYOT71FUuADMm6yRGi5x9AISPermZKiE2mZXdaSjpUjzDuOMhcHUN2vkQ6sp9YAoDeVU1L73JD+I8YsTOUU9gtLEk6NMzzkIfBwM+nInjWwKJl5oRlAesCXEYlmrhJiuJGkHpNOYxuvW8nejdOxgOTWRlg0lQ9Couw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9B5iD6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951DCC4CEF1;
	Fri, 31 Oct 2025 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898741;
	bh=AGxEpfdFzeMPLbbU8OvwzY2XUqW8zSz0RQQyFpRG6d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9B5iD6So1tBa+W3HGzzdrJEoYssS0I/TdaKA7iETf4GbEXCu8eFd4N07emeZtW56
	 V+IS7Iyijb7uQzSiI2cHacxEZzVs9qL16hGYusSWjQwaJv2YbFR0oKuDria3hAl3VS
	 oFA6KqXuvmAXuP6HgqfVGrcu6Wt79oXUjOfaNYB/DsochjvqB5NGCiSEid5QiypFLj
	 4qEbvqjfEP1VVqkXfOib2NJDYYoABI9TEWJz2s7zqOfUJNLVbKqcZdadh5BuD5CUYN
	 FGZohvODi6HmGpcVVMrruhTtwodRy4J4WI+hL1gRwd0Q5ilDY96c4Z7nhnksSgnDRq
	 6VMwh4Z4n2N9w==
Date: Fri, 31 Oct 2025 09:18:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jack Hsu <jh.hsu@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, srini@kernel.org, 
	ukleinek@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	daniel.lezcano@linaro.org, tglx@linutronix.de, chunfeng.yun@mediatek.com, 
	wim@linux-watchdog.org, linux@roeck-us.net, sean.wang@mediatek.com, 
	zhiyong.tao@mediatek.com, andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, 
	jitao.shi@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 07/11] dt-bindings: usb: Support MediaTek MT8189 evb
 board xhci
Message-ID: <20251031-clever-yak-of-expression-d9a6f1@kuoka>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-8-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-8-jh.hsu@mediatek.com>

On Thu, Oct 30, 2025 at 09:44:39PM +0800, Jack Hsu wrote:
> modify dt-binding for support mt8189 evb board dts node of xhci
> 
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 004d3ebec091..05cb6a219e5c 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -34,6 +34,7 @@ properties:
>            - mediatek,mt8183-xhci
>            - mediatek,mt8186-xhci
>            - mediatek,mt8188-xhci
> +          - mediatek,mt8189-xhci
>            - mediatek,mt8192-xhci
>            - mediatek,mt8195-xhci
>            - mediatek,mt8365-xhci
> @@ -119,6 +120,9 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  reset-names:
> +    maxItems: 1

No, drop. Not needed, not related, not explained in the commit msg,

Best regards,
Krzysztof


