Return-Path: <linux-pwm+bounces-7571-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5AC23CCF
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 09:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DD3BF7DA
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D92D8799;
	Fri, 31 Oct 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDRnDgoQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB88253957;
	Fri, 31 Oct 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898769; cv=none; b=j3vFLogIf27MUB2fTS7r6Urg2QN5AwAtMvF/IGADtPaYhDytFdrpYCR+Rzt3BUSfoWVHd2csUFlrvZcFjpvL8ZcrxabbYr2x9cRPU3eJ2DcMkmU0P+6Z5sINgD0aRakXpsjVoSbodCWKWQ+M+0+nmtQcyhBJnD7GC+9qp+/bLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898769; c=relaxed/simple;
	bh=KxNLKm898ISK9bg5Y6Dwq7+27/Y6B02z4sitZmbdhhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeL23nKmxWsR8pUknxVwcbhG21vYHd//SBcwrYCCx13Z2ZWxmQXdXNAwG3bVjtqOeIF0edejj1ccqW5ua8Wu236AEKtPG4Rc+G+CgYvDjZ7CjLCb2uEhgUH276Xa+AU8rEgoY0/YJzBDGRh1yR0FL/A7fJBYZwLoiYsESxV0YlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDRnDgoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2498BC4CEF1;
	Fri, 31 Oct 2025 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898768;
	bh=KxNLKm898ISK9bg5Y6Dwq7+27/Y6B02z4sitZmbdhhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDRnDgoQwv4gBXL/VUzJI6qGi4Zy3uokZrGwaE6SKKFuKRt+pTZT9gTjpAzBT/Co/
	 Qso8QrABj/VtulwZ4lvoIr5kWCpirgnjzq1uHgwIwczKNgrEluq2uofGwIYFdELjUY
	 PdkjBaZ3Ad2+4K0D9++HEFhucTPuw7Ca7DbD5Xo6hMZ98kj8GjyI88OlFGyZmT2V+1
	 rb0goahzfje7Ej6/vgknrOKQmAX3LVt9QkYa3gMMQDbCjJABz5fByn1zTVvpSsI+BG
	 9F4bbFi1MIW1bLytKYZ3uzPSKNN86cqFh+ZEYNvEaKpCdGDs5Bgbn7C4nuF4HeiykC
	 K71fxnhwQdSRQ==
Date: Fri, 31 Oct 2025 09:19:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jack Hsu <jh.hsu@mediatek.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	srini@kernel.org, ukleinek@kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	chunfeng.yun@mediatek.com, wim@linux-watchdog.org, linux@roeck-us.net, 
	sean.wang@mediatek.com, zhiyong.tao@mediatek.com, andrew-ct.chen@mediatek.com, 
	lala.lin@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 07/11] dt-bindings: usb: Support MediaTek MT8189 evb
 board xhci
Message-ID: <20251031-nifty-sticky-hoatzin-eeafeb@kuoka>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-8-jh.hsu@mediatek.com>
 <20251030-underwent-courier-1f4322e1cb34@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030-underwent-courier-1f4322e1cb34@spud>

On Thu, Oct 30, 2025 at 07:32:26PM +0000, Conor Dooley wrote:
> On Thu, Oct 30, 2025 at 09:44:39PM +0800, Jack Hsu wrote:
> > modify dt-binding for support mt8189 evb board dts node of xhci
> > 
> > Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml         | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > index 004d3ebec091..05cb6a219e5c 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > @@ -34,6 +34,7 @@ properties:
> >            - mediatek,mt8183-xhci
> >            - mediatek,mt8186-xhci
> >            - mediatek,mt8188-xhci
> > +          - mediatek,mt8189-xhci
> >            - mediatek,mt8192-xhci
> >            - mediatek,mt8195-xhci
> >            - mediatek,mt8365-xhci
> > @@ -119,6 +120,9 @@ properties:
> >    resets:
> >      maxItems: 1
> >  
> > +  reset-names:
> > +    maxItems: 1
> 
> Is this reset required on mt8189? Does it appear on other mediatek xhci
> controllers?

reset was there, it is the name added for some unknown reason.

Best regards,
Krzysztof


