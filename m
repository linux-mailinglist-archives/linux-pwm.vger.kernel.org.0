Return-Path: <linux-pwm+bounces-5125-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B8A57C0F
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Mar 2025 17:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A7B1891D33
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Mar 2025 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0F15B102;
	Sat,  8 Mar 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Xt+M408Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339DDDC5;
	Sat,  8 Mar 2025 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452436; cv=none; b=MPCXB+DMKMEad8lkJPh7aOh+TrMFeYqO578rIf2iLpTbkhnRYCNRbnJ+uDvf/kFN8fA20PfY0kQUGuMNN28ptZwciiLIqJS4lM07P/cKdkHfDujzQE4lYNzXXJF4F3lzot6lc+8/y2S98shHC1fBPWl9lkGkGFSBPrab/ey9968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452436; c=relaxed/simple;
	bh=OD2hOtHQa0uwK+Cr0jnQY97FmNfZwoPMsZKx2Stcwn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpbR8g750fIQdxt2WwfBz6tYrcTjkM7izoW5FQww2LV1H5A61vgj04PHgyiPbCzb8vgQ4twUrZ8Txr8bqw10wfDf8/JjX5dOJxhg9YjmQQ2Sx0JQowx4iT4itYF/YkHOOwySdSRSGPC7ZyQOUs9HZqsFxG8w0T3BWHaww+LtzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Xt+M408Y; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OD2hOtHQa0uwK+Cr0jnQY97FmNfZwoPMsZKx2Stcwn4=; b=Xt+M408YamdyCB/pMOD0BkKihm
	Hg6ZflaaQS2yqz405faQ82I6AxOV5ze5MwaXsxDiX7jKdOlcr18KDU9B5DRXEe4CHalzrA6aic/MM
	ITyEbZ0xgApQGzSXFTa71eg+cMXC+e9NvmU84UNo8p24AytPE34azJbvb5lU3TqzADoEc+h+nIbAT
	VTHUHySoUwGoyGdt5VQqBXcDVHq1KTZYnQx4OXtPUSrYIX9K1aYSr7O8ORPhsXPJMdipeOTo8byPj
	0aFzVLwicZTfM69yy6XoIt4cW8DCrHzIRLL27pKTUkjOD4ZK9UPEbOnMW+GXEyLIa2la5dZUzh2VN
	gdlbWLzA==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqwz8-0003oR-SC; Sat, 08 Mar 2025 17:25:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Yao Zi <ziyao@disroot.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
Date: Sat, 08 Mar 2025 17:25:09 +0100
Message-ID: <5942715.DvuYhMxLoT@phil>
In-Reply-To: <pnlkcc2rl7fegltovgtvp4xdxhonw72rclvhn7qmvb7xyuullm@xf5x6lcigji3>
References:
 <20250307120004.959980-1-amadeus@jmu.edu.cn>
 <20250307120004.959980-2-amadeus@jmu.edu.cn>
 <pnlkcc2rl7fegltovgtvp4xdxhonw72rclvhn7qmvb7xyuullm@xf5x6lcigji3>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Uwe,

Am Freitag, 7. M=C3=A4rz 2025, 18:07:47 MEZ schrieb Uwe Kleine-K=C3=B6nig:
> On Fri, Mar 07, 2025 at 08:00:03PM +0800, Chukun Pan wrote:
> > Document pwm compatible for rk3528 which is fallback compatible
> > of rk3328-pwm group.
> >=20
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>=20
> to prevent binding warnings it's probably sensible to let both patches
> go in via the same tree at the same time. Feel free to take the binding
> patch via rockchip/arm-soc.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>

You already have the rk3562 binding in your for-next branch [0], which
could create merge-conflicts later on.

This patch already contains it, so should fit neatly onto your branch.

And binding warnings only come from linux-next, so won't trigger as the
pwm will feed the binding there too :-)

So I guess it might be better to take the binding through the pwm tree
and me then picking up the dts patch.

=46or the binding
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


[0] https://web.git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/=
commit/?h=3Dpwm/for-next&id=3D058210e84b48dbb670a6bf72afaed6fbd8043a37



