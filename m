Return-Path: <linux-pwm+bounces-8407-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GEcIDEqymnX5gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8407-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:45:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F318535697E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A6030082B3
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9938237E;
	Mon, 30 Mar 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee8A+YDq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91D3A7583;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856746; cv=none; b=UBzgOeK7NC1EUi1sMyUHmFhTFSFjNGfvhxVJBh0UMNi0U780ktUxhU6GK3684pazvfv6lKhB+wk7kncq7W5u4tl8OJY6vz4hk4ViE7f0zmL2qw2Hnz6BCGl+1jLl/aYuACFufk819WylpgthDVSDrSFUa4hqBm4iT+iVJzyxFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856746; c=relaxed/simple;
	bh=lt96IhTtq+x/LAZoJN9Ko+HMV2ZVELDDXrMBeSvwCho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8o6NT477evYdJdGgw1oMqfpBLi63llBYZ8hzEIww6Q6L9HXrwdqzySA2MqR4qT9espFWUmQbuDICJzWtLLz+M7TIu/fhz28RyDiEZuJcRdpXXU85k5l3bYnx6ycrV1ry9jFTDroudMHU+/XBIJpITnlmBhh5aSckFF7bjGuAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee8A+YDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6682BC2BCB4;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774856745;
	bh=lt96IhTtq+x/LAZoJN9Ko+HMV2ZVELDDXrMBeSvwCho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ee8A+YDqr4SrtuIg2YyisdjH/6vXenu/saC1WGCcwoNKhwCNneE9ceweAambTSQZc
	 2OdssyfUQqhQSkCkj5SqrwCdhMhEOewXe6Ry6sje3XQFx9e9FmRNZL/29CnK/uuK6x
	 ODA77CGy1ZGs/rv73tkK7l7137NQXwfMatUVV9IRBX5414EVL0l5C9Si7S25y1ViZo
	 grc6t5MYFxk28X4vmzy6GO1Y+KpH/whUr2/6AsUuypLTgjG9m/kRcu4hlH/OBcRQKT
	 dAwE3velIDPfzrXDm2w3EXiF43Hgm/6JneB1VA/7F9kbQZyQtzcEU0Nj9+QEq8C3rD
	 GHegUyXE4N1gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADDFF495F;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Mon, 30 Mar 2026 15:45:45 +0800
Subject: [PATCH v5 3/3] MAINTAINERS: add an entry for Andes PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-andes-pwm-v5-3-01c59a659d2c@andestech.com>
References: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
In-Reply-To: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774856744; l=754;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=4pQDhCOlbkeQYIXwYzI13PZU9Hd+HgUg5c/mefmug2c=;
 b=W26hICo/KQMKfVCpTw1YTKEYdxDGxq6ScDubFHGD87BQorxWX4sZieYIB4K3lHSV2IqPBzdum
 st9P2xgQoPFA3PdYtfgRy1vFsNmaGRaZdHb1oUDR8Q6AR/FML8NLnuI
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8407-lists,linux-pwm=lfdr.de,ben717.andestech.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,android.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,andestech.com:email,andestech.com:replyto,andestech.com:mid]
X-Rspamd-Queue-Id: F318535697E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Zong-You Xie <ben717@andestech.com>

Add an entry for the Andes PWM driver to the MAINTAINERS file.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 708c050ac397..72eedd1a3428 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1866,6 +1866,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
 F:	drivers/spi/spi-atcspi200.c
 
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



