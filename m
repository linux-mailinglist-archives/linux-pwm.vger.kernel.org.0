Return-Path: <linux-pwm+bounces-8330-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uML7GhGTv2mQ6QMAu9opvQ
	(envelope-from <linux-pwm+bounces-8330-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 07:58:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5902E871E
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 949BB300D9ED
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Mar 2026 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146334751F;
	Sun, 22 Mar 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW09B80N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C43382F7;
	Sun, 22 Mar 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774162701; cv=none; b=lwGZhpN3Ytg+Ty7i5vXoKEIyjj4onXiMgtaaaf2nANHtYOlkhVCPGO4KGL31VAMJ4JyOrki7xap2raO7WAq2vjLXLuX/Il9Gj6aZCjfee4YgzOB3pMHq72HHiK5v7c2ahAJxVQWT9xIT9fvSaxwu/iMY1vC+3D6BlXO0Vy0xpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774162701; c=relaxed/simple;
	bh=J0oBN7mLaCh0P3ukmH4JfbB6/WVDt4bg5xlG51w0gkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwT29wZC5ET5LL+0S7HCe9s/laJiQtHFxisiTuciJOXbfuYgrAruGIgo9CtBZMHy+MmA/l6CNEBw6sLE40PgReIO5R44VwSMSYTIBz+x16Qlg7ojBMSGZvMbDRsFK5yQhSUJZKPmRJHwddj7cOlzysydG4larf0TBvbswDZlL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW09B80N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7219C19424;
	Sun, 22 Mar 2026 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774162701;
	bh=J0oBN7mLaCh0P3ukmH4JfbB6/WVDt4bg5xlG51w0gkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RW09B80NewEr4+1f/Osk33PN82xXXfxO25hunasttlPxf604ED3qxGuwu8o8TKWQH
	 tczxqj0fAJP8IAI7n3gp4Hh8ml2BMJkAdGzDRoW2N8rCB82KhnunsKRESx++5R0Utx
	 edq7YYXAVpThuWADs3Qb2zreAEQMwbYmt9qGbBb9J4dVskU/JzHr8URUUFWke04fRC
	 vR15cpT9G2h0siSFjnz/VFNwJuCH1/uLb0aEw0sogjpRgzall6GSPnpo/20J70W3/9
	 h6p75Ia0gNnApdSZUA2cpiaHGmJ7Frdi9M//aBIh+MU5AJeJVTKsxNzVgWAVPnZaqC
	 zNVsbDL/Dfy1Q==
From: William Breathitt Gray <wbg@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member
Date: Sun, 22 Mar 2026 15:58:11 +0900
Message-ID: <20260322065813.264398-1-wbg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260130122353.2263273-6-cosmin-gabriel.tanislav.xa@renesas.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=wbg@kernel.org; h=from:subject; bh=J0oBN7mLaCh0P3ukmH4JfbB6/WVDt4bg5xlG51w0gkU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJn7J132EdTIjTz28cnXxvqfcZrMBXK2rO6y+2eHv8yLO ml77/+9jlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiU54xMizf/zHeYVVGy7Sa xvdsq+Z3fpWr+2Ddd0+neeKv5Z9MYicx/M/sf5P9QSTpZLZbH+uNQI7PjL48e6u3Xz5xburJ4zI ZhlwA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8330-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA5902E871E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 30, 2026 at 02:23:53PM +0200, Cosmin Tanislav wrote:
> The counter driver can use HW channels 1 and 2, while the PWM driver can
> use HW channels 0, 1, 2, 3, 4, 6, 7.
> 
> The dev member is assigned both by the counter driver and the PWM driver
> for channels 1 and 2, to their own struct device instance, overwriting
> the previous value.
> 
> The sub-drivers race to assign their own struct device pointer to the
> same struct rz_mtu3_channel's dev member.
> 
> The dev member of struct rz_mtu3_channel is used by the counter
> sub-driver for runtime PM.
> 
> Depending on the probe order of the counter and PWM sub-drivers, the
> dev member may point to the wrong struct device instance, causing the
> counter sub-driver to do runtime PM actions on the wrong device.
> 
> To fix this, use the parent pointer of the counter, which is assigned
> during probe to the correct struct device, not the struct device pointer
> inside the shared struct rz_mtu3_channel.

It looks like you replace every instance of ch->dev in the file,
except in rz_mtu3_cnt_probe where it is initially set as ch->dev = dev.
Is that line in rz_mtu3_cnt_probe still needed, or can it now be removed
too?

William Breathitt Gray

