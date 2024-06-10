Return-Path: <linux-pwm+bounces-2407-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC79025BF
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD52F1F27DF6
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF213C819;
	Mon, 10 Jun 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TA4nWVli"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A491E51E;
	Mon, 10 Jun 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033702; cv=none; b=fDZ3fFeZMYFKqpuQaVC9z5pzzKKyZTFEULHgj22E0EZWMU++l6HQVgdYRjJwpf4fWmcl+0pZTOdm/cY6KMZa/HchHRaP6wx5XCEFyQQAoG8ZOceE26C7EIkEwyWphxQwBzSgLRNyoIFTjlYsy8MMMLLcV8X7PnvxmyMQEmkvX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033702; c=relaxed/simple;
	bh=BStw2xxDzN3fBF97z0N3Yeyjs5UEQMaIfpnr5g6sMII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HalsdU+g2c7+6g9d1UuwPc+Pky/mY1BUhg58NG5vjUNTMDFJKKrB3GzVuidrZtUMPHj7ejrjHAgRAm6bYLZZLNkm5fbZdAbD9qH6M4cCRvPRk3kPv5M4N1l8hC5/DXgVvXVhJb+moB9xd9bTRpNOsB2eQhDfzqZn+d81VTzcQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TA4nWVli; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 026DD39F;
	Mon, 10 Jun 2024 17:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718033687;
	bh=BStw2xxDzN3fBF97z0N3Yeyjs5UEQMaIfpnr5g6sMII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA4nWVligktR7ru7we3w0BpV+hHKnlpKAyGQJgJml9NXxL8Ke9dMnMENPCR8bqZAS
	 dIjxhiPZ0gv5AyujuOZnAriqPCPPlor6SrbnlGgfoNUeqLDjiUDpvNvhgeujL8zBkj
	 ZPTUGVbcbx7pd+LA2cRLnTN/leba3tYp9PJVOc/g=
Date: Mon, 10 Jun 2024 18:34:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: brgl@bgdev.pl, conor+dt@kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, robh@kernel.org, ukleinek@kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add Analog Devices ADP5585
Message-ID: <20240610153439.GX18479@pendragon.ideasonboard.com>
References: <20240608141633.2562-2-laurent.pinchart@ideasonboard.com>
 <ZmabVXaztPbp1ENV@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmabVXaztPbp1ENV@standask-GA-A55M-S2HP>

Hi Stanislav,

On Mon, Jun 10, 2024 at 08:21:09AM +0200, Stanislav Jakubek wrote:
> Hi Laurent,
> 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 0a419453d183..91e62df4b296 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -39,10 +39,6 @@ properties:
> >              # AD5110 - Nonvolatile Digital Potentiometer
> >            - adi,ad5110
> >              # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
> > -          - adi,adp5585
> > -            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
> > -          - adi,adp5585-02
> > -            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
> >            - adi,adp5589
> >              # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
> >            - adi,lt7182s
> 
> seems like you removed the wrong comment here? With this, ADP5589 would have
> a comment describing ADP5585.

Oops, my bad. You're absolutely right, thank you for catching this. I
will fix and send a new version.

-- 
Regards,

Laurent Pinchart

