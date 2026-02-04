Return-Path: <linux-pwm+bounces-8095-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KEoE3wug2kwjAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8095-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:33:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86FFE52C2
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E1E301A7D3
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3E83ECBCC;
	Wed,  4 Feb 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au9+sHeA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD013A1D19;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204642; cv=none; b=dVpFGwZUJPhQO0QpgD2ITpCiqHljuH8gDcb4vG53DZkuxygLx0Ujfiu+zgKNmxOabmb+ntyvLCUN5tzG8tnEU4ZAS4+a3lj3o2UhgVtMP0IFZxO5gioo1Dijse7+CgctOtarGaBc6WIPf0Hoa+noK+jiWzbKxogrwT4PVPb3Uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204642; c=relaxed/simple;
	bh=KOVm3C+Lsqdu0105X0Xiq4lwszVKTM1v3AwHILpokuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+DBDz4CXuAmD66JAE4tF5mrNFM+6eSp5xA8nRYStjEZUB2dZ2ajLvBhWy1Nr6GxoQ3wEVw9Xq32UwjSqP+/HxYRm8DrIX23Rwomw0MDQG8oxvhCENQUDkP7BhRmJOklKJPwvaNahsOmfDVATnr5PnQUXiGtjUrFnbwPYEaBVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au9+sHeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABCFDC2BC86;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204642;
	bh=KOVm3C+Lsqdu0105X0Xiq4lwszVKTM1v3AwHILpokuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Au9+sHeAGjBhm33g5kDKqgW4r9VzgR3x6zJJVOhbMXbJFrUjaNRbvKmG62JXzK0ga
	 NSMut2Kgn98NPVpbKsad5IbLQFq8qZzJ9aANR5Wc8g8paJPZE9HjfWwrshAyCtquKx
	 AA3lf2VK3g7+HzeCc3HYlD9wVKWojyqjV0Bkc8AwDNRtBk/v4eaQ87GA+JXqn6clAb
	 hcbCcad6AjBkRRpnhBJMArhX1/NnVNxb9H/DDIJRVhwsnxvs32zoHG1NvjWDxmQHYN
	 G6d3vT6WW4xRToZnB4lnaCZ3TSX5GpSc7EacmHyMTBE4QLK7x7z0xunYUroFuNHux+
	 nkVXkIvUjCyfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F90AE9538A;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 04 Feb 2026 19:30:43 +0800
Subject: [PATCH v4 3/3] MAINTAINERS: add an entry for Andes PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260204-andes-pwm-v4-3-67016bb13555@andestech.com>
References: <20260204-andes-pwm-v4-0-67016bb13555@andestech.com>
In-Reply-To: <20260204-andes-pwm-v4-0-67016bb13555@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770204641; l=718;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=L+fNVfc7JYf3+aGNasKyAhP0+tchIMKM44EzBGRUsVE=;
 b=dMDOp2I9fAG+kHI2pDIJDcSRPnnewYchBKmOPeVja702WL++cO63RH3O+uQ63cWrKSthH/Za+
 10Jr2KmL5TqCu/gY8CQDrRGwEpSsON5ZGJOhHwI64d8NGvdUhhihXBc
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8095-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[andestech.com:replyto,andestech.com:email,andestech.com:mid,android.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: A86FFE52C2
X-Rspamd-Action: no action

From: Ben Zong-You Xie <ben717@andestech.com>

Add an entry for the Andes PWM driver to the MAINTAINERS file.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75ebe5750242..536d692c0fb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,6 +1817,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES PWM DRIVER
+M:	Ben Zong-You Xie <ben717@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml
+F:	drivers/pwm/pwm-andes.c
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>

-- 
2.34.1



