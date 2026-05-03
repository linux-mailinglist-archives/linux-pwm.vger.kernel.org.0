Return-Path: <linux-pwm+bounces-8760-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N79OVUs92nEdAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8760-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 03 May 2026 13:07:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C15904B533A
	for <lists+linux-pwm@lfdr.de>; Sun, 03 May 2026 13:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78BCB30028C5
	for <lists+linux-pwm@lfdr.de>; Sun,  3 May 2026 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7232FE579;
	Sun,  3 May 2026 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY0hxcxN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA524E4A8;
	Sun,  3 May 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777806412; cv=none; b=d8UsmgNC2tlVLmJ79jyZxpCpsFyCKbhcaallPFiSwhTqZ+P7OCbKqnbjoBootKl4p8AVo9VpvxtL7wVlmuopDQi+c/CFU7lpEgo9xdpzMboV3RxdJfoThufLvbkeCAEiC6ZBwARPNhAl1SCO73bvsaM6CuKvtIvaEIe5rZ1h83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777806412; c=relaxed/simple;
	bh=YQOeN5BLc+pPy9v92y0mrqvir0VtBXLhse/m+6gpt68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on7TpUt3z1ZxJieQz89rfhCsroR3tZTv4n0mneH5oijQmnsF0R2pEsxKPPnibX5pJKiC0gNTOQJ2ewBVNBE6gfW0gguXBdhf34IwPHBE6hrXruKwkHcisxp1SSPw/+GDTURoJfHyrzo2m957mh36geTYcU5G9Xr7CFeKhL4jsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY0hxcxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CDBC2BCB4;
	Sun,  3 May 2026 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777806411;
	bh=YQOeN5BLc+pPy9v92y0mrqvir0VtBXLhse/m+6gpt68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sY0hxcxN2yrN+m4OPBZeYw7pWttaE94uan/AjdsPJ22WWMqj9w+YEXvNrBN2YghwE
	 cJif5MIeR+0k7UfKSilTVqQhmEJUMrx+fb0GwFHigphtEtCBViuKon7aTuj1jPnCsz
	 TxrwxKcvkMXboPsYcpBKrWuVSAZaBLUdMfR7Kffaa/QYtuxzBhCETgsZC51q3kD9WD
	 xodr5pu/pX/B4QQknUmOuKJawGk9ol3G4gpmuMcDVidKp7AVgweAX93PJFAG2Ezjty
	 CUWvVeyxRci7R8KJuv4D8Avt2l7290SzMvkXgoTNe59gXbsOSoM/CMpwUP51m8Mqxf
	 o5PliNtcqHYnw==
From: William Breathitt Gray <wbg@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Alexey Charkov <alchark@gmail.com>,
	linux-rockchip@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
Date: Sun,  3 May 2026 20:06:43 +0900
Message-ID: <20260503110644.462016-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <q0kG3ZZyT92lQlYsvZD_qg@collabora.com>
References: <q0kG3ZZyT92lQlYsvZD_qg@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=wbg@kernel.org; h=from:subject; bh=YQOeN5BLc+pPy9v92y0mrqvir0VtBXLhse/m+6gpt68=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJnfdXSjr+uG9LolLH+69rEAp8L++Qpsv/iEOfd9/7FYO 2LLJdsNHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBE0l8xMnTNE9hydJfidDbB cPdjUssKRfzfqV9z5XlTyWx3+odinREjwyLnzQ2Vefe9l7o67xPmtlsRfTpUcf3xbRJmKg/1F7m vYgYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C15904B533A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org,foss.st.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-8760-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 07:35:32PM +0200, Nicolas Frattaroli wrote:
> On Sunday, 26 April 2026 12:55:20 Central European Summer Time Damon Ding wrote:
> > BTW: Is there any user-space test tool similar to libpwm for the
> > counter subsystem?
> 
> I've tried looking for this as well, and couldn't find anything. If
> it exists then adding a mention of it to generic-counter.rst would
> be in order I think.

Fabrice Gasnier added a Counter chrdev userspace test application to
watch Counter events; it's at tools/counter/counter_watch_events.c if
you are interested in trying it out.

I do need to update generic-counter.rst to add a few new things we've
picked up over the years, so it is on my general to-do list.

William Breathitt Gray

