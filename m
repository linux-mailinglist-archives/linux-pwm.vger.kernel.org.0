Return-Path: <linux-pwm+bounces-7535-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A9C1F9A1
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B353A1E60
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0E340264;
	Thu, 30 Oct 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Dipggkwh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0432570D;
	Thu, 30 Oct 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820818; cv=none; b=Aofy1vg7tbte5JnOYDW1B/xbemu+wMOk+XeG+it4jMBogHn1Bu+WPDD3k/NiEvFW+GIdon+3nB6MjZVgPbwo7jMRxCVD9epLgAKIbrzqcy5jjoeJJm5V6JC7BYZIxjTlIqOposBz2/gopr1YbXfQduGAk5fQKNAd7KY2bNnhqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820818; c=relaxed/simple;
	bh=8Vzuw1iAvx1zgZghcv2owGbdLTGXx8dqKeXVGD0+4B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5yYUbF9fOj8qkKQSLmwYFigAmnnvgxzjt7wHETPcflT9wkkxMVPc9+uS/FtJBG4MGKuklQkf2ffQULGjLwtod8hbjLOBcN/Yn52LI4TeETHFLxsCZn1VkETDn5kUP2JYZmNBwQvlqLMQJHpLDCkK50zkhWUzHGt5ZDVjm9HYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Dipggkwh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RCywyWtPG7xhPz4mDJsFONHwjktY6zCv82HEx1Rjk2s=; b=DipggkwhifOTGFbt6Tw5h2OBCG
	ShvA3eH+PJz5SAosWXlC6MzBX0ny72o8hYDYFpCd5ZK9t17vVAL7cnGRxOkUqXQj27Sp9XpKs3uvC
	O3SEkV74W7Luyvz+J6dpAqBP4jxEu1R5EjfqvFHoejfVCpjfRI2hlEMc0QFR7Bf8nFdQke89adTkV
	nu5PTgG+SEC2sNHaPYTG4pjLAhZCujDjhj3rGYHxFH3kG4/9go3ViQTBk5j7F2PcqHJsmjq2aFvI/
	5yFSXd+d92/XAiED1/xTe2pTex1tL8h+M0oGuwIGJYAt7YVzmXUJStuz35ynhA7hNd5+2rO0ZQiEc
	8APENvFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34098)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEQ4g-000000005ZB-0ady;
	Thu, 30 Oct 2025 10:40:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEQ4e-000000008Oe-2a4n;
	Thu, 30 Oct 2025 10:40:08 +0000
Date: Thu, 30 Oct 2025 10:40:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Krebs, Olaf" <Olaf.Krebs@emh-metering.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix IMX PWM period setting
Message-ID: <aQNAiDVKahkIrLYA@shell.armlinux.org.uk>
References: <20251030084727.4098222-1-user@jenkins>
 <c26fde7dff3a41ff9f7e6c97e2a31801@emh-metering.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26fde7dff3a41ff9f7e6c97e2a31801@emh-metering.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 30, 2025 at 08:51:20AM +0000, Krebs, Olaf wrote:
> From: Olaf krebs <olaf.krebs@emh-metering.com>
> 
> We use 3 PWM channels to control an RGB LED. Without this patch we get an error:

Not build-tested.

> -		if (tpm->user_count > 1)
> +		if ((tpm->user_count > 1) && (tmp->real_period != 0))

"tmp" vs "tpm". As there's no variable called "tmp" in this function...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

