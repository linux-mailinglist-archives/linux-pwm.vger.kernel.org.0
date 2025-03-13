Return-Path: <linux-pwm+bounces-5179-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78080A60414
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4493880A9A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 22:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0211F76C0;
	Thu, 13 Mar 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hbr+6sOM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80511F791A;
	Thu, 13 Mar 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904067; cv=none; b=py8/DLcEn0byZyxQcf0faGUZ23IfRdfsuhmGQPZMOSIv7zmXt2Y3Ikzp5atEyy4nA6BNY7eXjePCQ93GJ2XzjX1weQEK/sLaEINCjsz4NVTJTjHQMpuwhJa5+14ShtWk8o0KTPUzvQy3O8GgMoZWTITl9aDwbuuLk2n9CtMQL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904067; c=relaxed/simple;
	bh=ayENqWRYykqKMSaDdgouWzzeeWpkub6h14X1CWsUIWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkBNWutfheXAIS0GaNxFUpnSL9BlbFH5Eiy95jzmfLCWzADuPbqCiYPjH1ZUkMMB53RFQTxqNmX3ApK7ETV2QpQTExWYXAkDAMOzf9EyXh57iZgriWzTwOib3IHo/hW4PD82lWhewQIZoW3M/cXsxE0Q3SppmQbYpRKBKaaOJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hbr+6sOM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ayENqWRYykqKMSaDdgouWzzeeWpkub6h14X1CWsUIWY=; b=hbr+6sOMUOohmJsjF5BXVys2lg
	oAuBs8vSReUdYyq0GZhOT2JLtY1OqxHtEr/x+5UWWm6gv1s8mp0pJfTALrWhkrSglwOhiN4MDu9P3
	HMyRbLQvdy6BndmlF15t7lsziwXrqLiUQ3qeUAAtlpIuOVtrsIj1yvX76MNcduysfwTtMclHwZDE9
	o95TkLbPWNQxgDpskFxwkFzncrMHnoyj8lwD6RpWXqcb9uD+M0q0BwGv2yUGug5/kRC4CR2zXRRJD
	g3jFunuwzDFkcbuBmkkcy3NNdf8e1y0KelHXl5i4xSLU9AH6aydSqNfZGmJ5YcpUFh8RNOfXmktkJ
	0UnKXYaA==;
Received: from i53875bc6.versanet.de ([83.135.91.198] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsqoi-0002tC-Ns; Thu, 13 Mar 2025 23:14:16 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: amadeus@jmu.edu.cn, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jonas@kwiboo.se, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Thu, 13 Mar 2025 23:14:15 +0100
Message-ID: <1819496.VLH7GnMWUR@phil>
In-Reply-To: <20250313071031.1840032-1-amadeus@jmu.edu.cn>
References:
 <7779050.EvYhyI6sBW@phil> <20250313071031.1840032-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 13. M=C3=A4rz 2025, 08:10:31 MEZ schrieb Chukun Pan:
> Hi,
>=20
> > so yes of course the pinctrl needs to be default - simply because
> > that's the only pinctrl state mainline supports.
>=20
> > But judging by the fact that you're discussing working vs. non-working
> > below, can you please check if we should drop the patch for 6.15 till
> > that is solved?
>=20
> I suggest dropping this patch first, I will send v2
> when this issue is solved.

I've dropped the patch now.


Heiko



