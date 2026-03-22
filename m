Return-Path: <linux-pwm+bounces-8331-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1o+hIC2Wv2k56gMAu9opvQ
	(envelope-from <linux-pwm+bounces-8331-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 08:11:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9C2E8781
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 08:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E287300F51B
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BC346FD2;
	Sun, 22 Mar 2026 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coz374m3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38751A6812;
	Sun, 22 Mar 2026 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774163498; cv=none; b=XHi970LGkh1DOYjERRvBLT3cCKcC3kY7gKe/rooKiA5QUeKeHXmOtO1eo8ZVXJLR0uvlC5MOK84vafXq3KPc5sWAxtcjoVFqYZVmEVIgmSfHaTLt9CyTtHrws71sd7jblnaLJWMRtdZQphYwHw6RBwgKFOI1K6XyqKj7eS6aino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774163498; c=relaxed/simple;
	bh=2ETpkbizVpBFMURf4dwPJMkqf9wn3Q2Q+Zu65QPLDp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFvjS6b8YXY35vlJDi087jYKsE7U4XylnphpPQIOLvlDMGe4wTCXl+BuzwV/ZR3yAoJz52CBIQxbeeid345gGLXdtya0dwHzoKONbfYq9mzajl7q8Bgba+ziz/rnRp4JqUNupVA+mlVVjT0JfsNEL2y4mi2ocML/Z0QumptUHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coz374m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4D9C19424;
	Sun, 22 Mar 2026 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774163498;
	bh=2ETpkbizVpBFMURf4dwPJMkqf9wn3Q2Q+Zu65QPLDp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coz374m3EJkJ6wf8hVLfnu0AjiulkHCG3NLvL5ndypRGLxmbwNR+Ab84i2/kYLQvB
	 TO9Y6EcgYit4TAJPwf/XHwo4k6tiwCNd7Mr4sDa4SDZAHuSULx/yNtochgDm44aCep
	 aZtzG6lm0cXXWqUsrYFcdYdPLW+zVJ6YftOEtdu2+XVnnEZIw/3X9FtF0vCgzD3qtq
	 jzCAUuE/ZwTGYJY+l3WDe2aI0rCZPd78jAdTYkDFBKAd27BDoM3yT3XHFjYq0AzaIT
	 Tn1fnRdPIFd/AWIzwe4T17961Pf0A2ZLXNq0hGTwLaXHT4NoS6DTeiLC0ZyFaE4SPt
	 yn30ePBCjImQQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] Renesas MTU3 PWM / counter fixes
Date: Sun, 22 Mar 2026 16:11:26 +0900
Message-ID: <177416337638.265086.4996720678255176090.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=wbg@kernel.org; h=from:subject:message-id; bh=9khczEBkG41MevuIQXBP0qfvpAmNzFR+y0zDl4qjdEc=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJn7p57Mb/+uzMh9dsuh1rV5l9+vi5ifsMnig2914FXpi tvR4u5cHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEXt1jZHia39MqbyR0e8Wj s36L/ZJWH3nLsoM1J7LpToTe7ftvZI8x/I9MUXQsu3hLxu7h/S3v5s1a+GAdSxrX1T0LRasevem 4EcABAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8331-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3B9C2E8781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 30 Jan 2026 14:23:48 +0200, Cosmin Tanislav wrote:
> The Renesas MTU3 PWM and counter drivers have some issues which have
> been observed while adding support for the Renesas RZ/T2H and RZ/N2H
> SoCs.
> 
> This series fixes the most important issues which prevent normal
> functioning of the driver, while other less important issues will be
> handled in a future series.
> 
> [...]

Applied, thanks!

[4/5] counter: rz-mtu3-cnt: prevent counter from being toggled multiple times
      commit: 67c3f99bed6f422ba343d2b70a2eeeccdfd91bef
[5/5] counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member
      commit: 2932095c114b98cbb40ccf34fc00d613cb17cead

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

