Return-Path: <linux-pwm+bounces-5022-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5EA4A438
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0C9886339
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27493276051;
	Fri, 28 Feb 2025 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq8lSCVj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12D276047;
	Fri, 28 Feb 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773923; cv=none; b=cHpfe5xKExfBWX15F/twRIB2fUAthAsDXg1fBc1FjTYUss3Hz/B+MOR9ctQ1cEP6VWGLw3CDRHFrtXxR7CYd77WuDDsT/pw3ouXbrkBSi+ItYooECX13k9KyUDjVZvA75vToLvO1Gc4U8YhzkoME6vW+5ma0IJVzzitAPaRBhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773923; c=relaxed/simple;
	bh=V2fl3SgaIv/iZpUxldERtVxJc8Gc9wwGAYggoa3JnAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbFu+Z/ot/y5dyq6kzojmIKgG16gAsvNrV2f51RAbQf+/XBaI+AvUIJi3cFS03Qh4hmyhQ+B7LuTc+9xO6dCQ5sUaqI/Hb4flXP2HrSneCREnXgWKy5URbDPMEGcHwGooAE052CDYA7YKIfuXWNHe0bdmiU2qlM5+qQYX2ujJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq8lSCVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441AAC4CED6;
	Fri, 28 Feb 2025 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773922;
	bh=V2fl3SgaIv/iZpUxldERtVxJc8Gc9wwGAYggoa3JnAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vq8lSCVjYJ7kNomfOpDiDI4zLDvUHCIv4xqmv36beFMQe45Nxc+MG+EhZl0lbl/D0
	 536pdMwmSXRiwwchmYyWwCkilaA41iHeYyyEL8PV+dcBO2DNzjdEHf86YB5zm71YDI
	 ti1pSKJfhhZWlz/819qnQlFTu5kqwSTyuoD+hp8QuXTcQWXxtl20vgea9j6Bop1oTx
	 6M51LvlxxcETRyJB7ZwO4lri73OdAGi5msNk4m+bArV9Je8zMnYPm7taxCoqmqYxST
	 gOHRy9VgFCMXnF4UyTOqZBtiu0waOX+GFZY2yr1/GloKBtvePdaPrCt4xvqvFhWsvZ
	 5B5m9txGc2IGA==
Date: Fri, 28 Feb 2025 14:18:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Conor Dooley <conor+dt@kernel.org>, heiko@sntech.de,
	linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 10/15] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <174077391956.3606575.7362792715145083810.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-11-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227111913.2344207-11-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:08 +0800, Kever Yang wrote:
> The PWM core on Rockchip's RK3562 is the same as the one already
> included in RK3328. Extend the binding accordingly to allow
> 
> 	compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
> ---
> 
> Changes in v3:
> - Update the commit message and collect the Acked-by tag.
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


