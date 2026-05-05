Return-Path: <linux-pwm+bounces-8772-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I5jC8fU+Wk1EgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8772-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:30:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A64CCA85
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42EDE30FFB52
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45C423176;
	Tue,  5 May 2026 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="LNc8NrT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzG39iDe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF7421A0C;
	Tue,  5 May 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978987; cv=none; b=ZAaug0r7/1nusnF2Ik040z+o0bslla8SlUWupoJqK0PDmTEzPrqCgn5l/HRBmVogXpo2NrkcN/ZDEjg5NQkjkwKC+xJwmlehkqdMpeCtoOjddYvqPoSlSY7uVYIYM/ONJLXnMiTEwYpCJHvY3DWSyQDBtwlGUKte9CKkSLfTrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978987; c=relaxed/simple;
	bh=v3VFWaz90916Vt3W0q5xTV1SO3iqzrjNVjydD1K3Sd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZYCD8tyVrGfAI+n79+c5WneTtyL0B08cSQHuNnZCioeFQjH5sAz4QGF+AcpqdmjPt82n6hajgFAaUcxPUcECZNPImxziiWmEIhtyVupQ9/hCHCgtYtNLDNiw7cSBBgbUhAbXYXQE/0VqmP0sqITCU1/mzSI/i0Yp95RYpo4eF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=LNc8NrT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzG39iDe; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD69C7A012A;
	Tue,  5 May 2026 07:03:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 07:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777978983;
	 x=1778065383; bh=YRt9IneYAHIH0sZGh01M8ZB/vtqtUvbYE19BEN3veSA=; b=
	LNc8NrT9XmghYrDXkRxdcUTPmqKidcyTAJimgWf21O224qfe9Xy3GFyUzEYSZX+E
	SzjI6DeItLdffPJMcUFbna4IWYyUu+ZOfCqJNKkQDYzz+gBmyYW/Vwx2nr82dHJx
	DZ7E/s/CUEn/5qtY8d6n7+QQUyhQaynmFrWXkoYPyqhkfGbcc/uyM3Q8+nIbYio9
	rZEmAihaFAOr2qK66yiQy8fc5P+Jqro6805p6GcOqunvUd5FFhV2yd2/JGAjWW5Y
	Y9oKAzwYpr/qQHYsCusxJJ1Sg2F7BHF8fOYdy6u4/pVxQdgIYcONyY36S3dj59YL
	0uyGmzBxMQbc4Ib+zfc+IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777978983; x=
	1778065383; bh=YRt9IneYAHIH0sZGh01M8ZB/vtqtUvbYE19BEN3veSA=; b=G
	zG39iDe+K806o9MCvXSI6g0PGU2C1slgdOYVpBj/w800NswknPMzpY/I6cparCV6
	V16qVtR142BFd2zx12fRkaFAZqORhT/n/zpg80px1r5Q6m04oeEFlH+Zxewp/YJp
	8skplY8t6k4+oREriXeJjiucBRCinWHLBWleX1O6KcXieJ0wLRnUdBvBCOYxcJXS
	028Q8VFD1WjyCjqrnw/eiwqiRqBL5sqMY+db6DGI0IEkm7nUWHP1fXt4R0Vh/W94
	eFEJUZS0KvFG2AU+cXrHHCID5l5fh8fZTOPDOFXrTzXFbMzwXsY95/To+AJV1jJf
	e7th7mLem3ceRVNBd34GQ==
X-ME-Sender: <xms:Z875aTLOuaWaNJOiUUzph5d66pH593lLG9MBmR17zzYn2BYaa5nhLQ>
    <xme:Z875acCOR26eJV9wtDtVu2GNjPESTu2z9gK63qunU9of9dhP5QElAg3yhPfMSxadJ
    MPu6g8gqC8A3Ulqqf42PwcuVi6cjNoZRrrLJCzAwmhXZ1zCD35L6w>
X-ME-Received: <xmr:Z875aUSQBIvkDi8OkLb2u4qbwX1ZzADDV_mwqB3in74iEpjflAyyM0gyWaTPPSSypV70zaz16rEuiEBG4frXxQb9Db3Ya0iCzYeK9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeif
    ihhmsehlihhnuhigqdifrghttghhughoghdrohhrghdprhgtphhtthhopehukhhlvghinh
    gvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhg
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhpvghishgrtghhsehusg
    hunhhtuhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtohepkh
    hriihkodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z875adrTQR35QNIWXWSmOPxZTVMjmFh5aUE48noQ53vcxOM5Rol_Ig>
    <xmx:Z875adX2aPvsDh2QhYRcdU06evNt_8f_ju16-rWre19Tm2sQ7uBdxg>
    <xmx:Z875ab9gQ-9nzz7_4AYkgeds4fI_u3r3XLC0qY6568RKXQh0c1iT4w>
    <xmx:Z875aVaEG7azyyPD_EzlOfosmGV44NmXlEWhd_MI7fGyQrh8bGnG1g>
    <xmx:Z875aSLDhj6rKVUWVaByGsnVsksq-Gji54gT3F6r6-HWikWTk_La2QJz>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 07:03:02 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Tue, 05 May 2026 13:02:39 +0200
Subject: [PATCH v2 1/6] dt-bindings: arm: apple: apple,pmgr: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-apple-m3-initial-devicetrees-v2-1-b0c2f3519e0e@jannau.net>
References: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Kettenis <kettenis@openbsd.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Joshua Peisach <jpeisach@ubuntu.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=v3VFWaz90916Vt3W0q5xTV1SO3iqzrjNVjydD1K3Sd4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyf5+L1Gk1m3VNj/h10lVm9eA/HyoTU+FaDo4p1jnOez
 3x/+F1rRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImcPMXIsH92iPnrt6b1Ic83
 i4o+7tRb4nTjyPd7jz6/feey++DZZSoM/8vYWwPaN+pU3QwtVtwWx7LrQLKTy+ZVoasXlm+2V3O
 J5AMA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 818A64CCA85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8772-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:email,jannau.net:dkim,jannau.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,ubuntu.com:email,gompa.dev:email]

The PMGR blocks on Apple silicon M3 SoCs (t8122) are compatible with the
M1 and M2 predecessors. Add "apple,t8122-pmgr" as M3 specific
compatible.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index b88f41a225a3..c67b67ba065a 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -36,7 +36,9 @@ properties:
           - const: syscon
           - const: simple-mfd
       - items:
-          - const: apple,t6020-pmgr
+          - enum:
+              - apple,t6020-pmgr
+              - apple,t8122-pmgr
           - const: apple,t8103-pmgr
           - const: syscon
           - const: simple-mfd

-- 
2.54.0


