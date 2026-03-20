Return-Path: <linux-pwm+bounces-8305-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PLoEO49vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8305-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:30:38 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E30132DA451
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF52231755D2
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF43B0AC5;
	Fri, 20 Mar 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="aSNMdqtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOhuGUzd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42783AD531;
	Fri, 20 Mar 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009432; cv=none; b=cEk6VvOSqEcVQUn5ws6KHUG11XvKA90CVkGqzZwfEvtBdQd/wKXeE6GCeMbz/OM131CuYDLmBdyAj2WEco7b+h2vxVI0GQA7WlJ/ObLuI3U9bJsPdb0YT7Z8uJCt+uvvub2Ei8G0rZd32W3eHsKernGOgpRgFvkwdll6CmEulGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009432; c=relaxed/simple;
	bh=CRqwtHlpqFRC4nilq/tn1g3vvR4xjr6yUypxPRc2YY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMNIgjWgsO9pY5O5YbW9/XJwb7vLcL7qq07mqj9jExp4OJjFWInzZi+FU7zzEk1+B0VggF35fCw1GCpCW+kWV/E54zEKs9tvgMWmnZ32XgrU9V5X1k6Jpoz82NOLUEpdwtLryrFEFOuiowW569UjldkA/ldo1rmrJmKPL+los/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=aSNMdqtc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOhuGUzd; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 3E8BF13800E9;
	Fri, 20 Mar 2026 08:23:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 08:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009428;
	 x=1774016628; bh=KytEPja3IuZXZELlpY9baRDFVTxYpRDBduUOWw1Wc5Y=; b=
	aSNMdqtcQiaGNn9G5WA88m8IXFpCQH/wbfpJKjjS7tyGkLLgKrWfhhSfAe4Ps2jy
	Etsh4eIRdcjNP5UWch1I/1cAq7bgHqNrhlsEZSLMg2TGF7RqgDBdAC7zFhILKyb+
	GRLGfd/1cwDhyXQb+g9942DC4OV+MC/+EOvD2mMIrLyYbqqPWh/383m0SINxPGz1
	5m+LwOBuJPlDE8QGtnoVMZx1ufmvPEXgZ2xpXWqJLMLQAkhRsNxQIMe5uaNghqPa
	iQ0rhPSzU2Fz3/QnVrqnJWUGx/Sq//mvbw62DF7yaZMlo0VeApQFH97VXKgdYm2F
	QPzblOYykpdCzClQ60m3+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009428; x=
	1774016628; bh=KytEPja3IuZXZELlpY9baRDFVTxYpRDBduUOWw1Wc5Y=; b=Y
	OhuGUzdb1bMJmxZWY6VfwVeZ6gFOJXzkvmD8vuAPxISEoidV1bLlsPJgVcLETk9P
	hG3Hc0dBOYo1aFV7DZvZkejb/Mj2C5pQzPM32OJ3Odsm0bRnUY3U2lOpRjd1HXgu
	i9P7S8Y2E2KqG72cYMiBdGJJIkjjFOo8zpgZvlEfQzWCOOEdfvzCkYz07lfMsXSw
	HOnFTnAYWENf1y/MX3DLd827DrE9KDY2ZS4ofDXljPgzuJYt3YiO3t8xc2PgPc9t
	R86RYU7iGiQYSLsBtIH/SY93g9rVb/qhO2ctyA8nNk24tt2uDjmpjzzo3etpeRqM
	KWOtcoKJwDNTcuSiaoQqg==
X-ME-Sender: <xms:VDy9aaCYtmX49AMlbSgWphAuZNy4YqmKZ-WsRBjWVI0qrU412SBWmQ>
    <xme:VDy9aZavr9HHK2h8sVwIwTPdmtDZV8zFF0qpl4ePMhLPOiGtSdRrB_yAV77QRWcWJ
    D-h2cKTkFC7tBVAvs9QGaAT_Fo7XZYBcTlcAzNNcjR-ipJR8_MLn09i>
X-ME-Received: <xmr:VDy9abKXAmrxZnJz2ifo5XdCn62zD6hQ1jgkZbF6qq_AVEe5fP4Ha1MRzrwlQESYmFd_62CwrnK4GDIf2PwDcLYFl4IioaLk5ShO0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhushifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhg
    pdhrtghpthhtoheplhhinhhugidqihdvtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhmsehlihhnuhigqdifrghttghhughoghdrohhrgh
X-ME-Proxy: <xmx:VDy9aa1SH7h5dNgeZ-hM3oYHajBDffNSOklNd7Uop20mRECWCZRRIg>
    <xmx:VDy9aeb6YWPBro_oe5HzReb-pKvTNmvCHN4lFcK6OOQzstmO-kxdvw>
    <xmx:VDy9aVW_VOa6252qc6HxdLRtC8vCzLl9Qjw8Diy5y0HZNlTNv_p6EA>
    <xmx:VDy9aRcVFZdxgBaHXFSZ5dZmOLLt_GrE4-KpJHVqjuQGmv1kVMQU6w>
    <xmx:VDy9aXuz5kzEytXpLKZgi-wdTZTF_Kk4y0RvejRnsQ-i2--NETznm0RA>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:47 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:23 +0100
Subject: [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=CRqwtHlpqFRC4nilq/tn1g3vvR4xjr6yUypxPRc2YY8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nu59ggF+ljVNDQyaLFMmV1eZcfJPnsj9/dDOKAbfU
 tYJxZkdpSwMYlwMsmKKLEnaLzsYVtcoxtQ+CIOZw8oEMoSBi1MAJjK3jpGhNfJrzz6GTdenm15y
 Mcn7GX24cx3PiQ9Twn8evZ0uNLe7leEP97TsS6cm53afmb5lfeG+R1X3a6WyjLoDHyjZ73R71if
 JAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8305-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E30132DA451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pin controller on the Apple silicon t8122 (M3) SoC is compatible
with the existing driver. Add "apple,t8122-pinctrl" as SoC specific
compatible under "apple,t8103-pinctrl" used by the driver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 665ec79a69f1db1020668c68ecbb7e215cb7cb28..41073176bc691bb1b284037f9ccfe2d036160e71 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -18,7 +18,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: apple,t6020-pinctrl
+          - enum:
+              - apple,t6020-pinctrl
+              - apple,t8122-pinctrl
           - const: apple,t8103-pinctrl
       - items:
           # Do not add additional SoC to this list.

-- 
2.53.0


