Return-Path: <linux-pwm+bounces-8775-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KIjI//T+WlHEgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8775-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:26:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3BE4CC9B7
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 918D4307426A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C043C07F;
	Tue,  5 May 2026 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Xm19n2oX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CXliGvqn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99043C06A;
	Tue,  5 May 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978993; cv=none; b=e66LOYfuaENBxEWblpSgvRTw0tcferzEorWkWVsFaaS7/aB4lGlKbFSs41vCTMHfcVQ6XgH1mMtq++U2mpCs/+NX5sVFRGaDBqjjKTqT0ZdK8RLeQlg1EEXBOxjfciI1PeGEDxifzGlTkAqQwKGNVykxYVPOPpgfPkSOxfj86K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978993; c=relaxed/simple;
	bh=gUN8s2Ri7zG9BdlChN+PUyMx26oLN03c/SpGRdRYMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPAik8LAF2JFROD/AeTELlp5u58pzOh4S9Ww+jKmYc1D1OiiVZSVGmWkcJlgK9CFfkz05Nlp0KvsN8UFJ2Coeh61TR7n1/m8USe2jwUHOYwQwS/YYhVT70Q7RFDH5wWLxpLAAJN0+fGI+tliWlUq3pCdws4Jz9BF/ftA9gBdkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Xm19n2oX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CXliGvqn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0E9D7A00F9;
	Tue,  5 May 2026 07:03:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 05 May 2026 07:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777978991;
	 x=1778065391; bh=U0DLBQ104H4pRJmAnhQAaxKxLWgSeWObdD3M2XI1ycA=; b=
	Xm19n2oXQlkfpl7PD05knKysNHYSX/DZC6xWdl0KGZikxAsQ2xKQ4Cl2Y/QZqu6h
	N7XfULeSMKJMP8JhpZUlJ2FXlJkWy/uXt+dJh+xNtDplcLqcIOzfS7e7ZrD6RKkg
	/8SPVF46HR6rbc3WhqNysnuY63Og/RLNznfcQ7aQAWjuvle0vwX7DtE6h+5fxaZs
	xduD8YZXW16O9zHIMnIKh/4AP+f4US8wxuQyPL92uclXakO5gbtSi+lnZnYANTkt
	WrfqNlLh3C8uT83qhLStmJVKCthcUsB4+qCJGJb1c+kI2AA91KWEAD8Gnt0cFy/r
	eFG3E4RmVaryde5uQ9natg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777978991; x=
	1778065391; bh=U0DLBQ104H4pRJmAnhQAaxKxLWgSeWObdD3M2XI1ycA=; b=C
	XliGvqnT3Nqf7DRfQJEV32dEYwkIWY40zvFXYyY0MVpgkXhgzBjxhY1YWLzACZwB
	R4djKXV1PCe3G58huIs1tdY9l2TSSOSzygIR6InvRv5xEWO0IG9VtJ1wmDYzF9YO
	nCiOkj5c2Z58Eg/ae2NrwOpvJERdsxmYV0zdF0ZR2avFoEWq283aD6ioxgqwswBb
	sDvAc7zeGsY9KpY4QppLxXuCqeZ2tb/zVcDZa5YWqPHw3yH5zGxPJduZIx6bHJK0
	SWdEv0lNLN9bTy8+IpaLbOIcaa6rxMi0rvje5GE+hnwne7DYcoiiSShTpw9O6EM/
	Rcvask8AuylnlGfQwTgbw==
X-ME-Sender: <xms:b875adbo5zz61EYJmpRiN-a-Tf31XkwFzcjO20QbJoHdAZyOqwatNA>
    <xme:b875aZQ-CAAr1L1vW7CpyanwkXgCMO8EmT4sHq32HMfpDfzhWs1TMFlOZlleVGY8H
    gSYMl5YZdQI2XS_Zg3j5KqN25rrI50C9nYJ3VdqBhrWBjI2PiqO9Q>
X-ME-Received: <xmr:b875aYjld6fqsNualD1kCroMf4bSFWX44NBLw-8pMOg5T5x3tr7ESbY2-wTQ2prdmC7-YAVPtzYMknHBfcGYWYoLU0jvm3iRRTwkWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    ekieetieeltdetieetfeevieejtdeileelieetleegjefghfejvefhgefhvdeknecuvehl
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
X-ME-Proxy: <xmx:b875ac45qGt3YsKntDBkUmfmcZsi07UFMLO-2n8NOx4luWxYuec-UQ>
    <xmx:b875abmXi_FwqmY1DzUjJlw8M5iyAJ_xPJDhrvry-NAEpG-ITF8S8Q>
    <xmx:b875adO5vuJ0F5Z4mnU4LecPXvUsAtF6pm3ayDXBidsbf90aQ9PWgQ>
    <xmx:b875adppGKrPTXLa-kDmLid02qJfFdImwTs4_QmAdojFj7846PeATw>
    <xmx:b875abYSIFQ-C8DC67Zd8AtwBDuHvGnc04ZEH_MU3wUkZo94vayY-9Ep>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 07:03:10 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Tue, 05 May 2026 13:02:42 +0200
Subject: [PATCH v2 4/6] dt-bindings: pwm: apple,s5l-fpwm: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-apple-m3-initial-devicetrees-v2-4-b0c2f3519e0e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=gUN8s2Ri7zG9BdlChN+PUyMx26oLN03c/SpGRdRYMTI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyf5+JVAxwT7WwO7jN17Vzqeu7Fl7l1H8INnd+vTXd7P
 Vtm/bPTHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZioMjIsLDtk6hzpHf669e5
 XSXnu/4eW72mXZSt/srJm0uW622TUGT4Z7p+ztmUIyfLdjgc73rzvPj+q4i7k95sn/Ns68RVzhf
 YfdgA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 0F3BE4CC9B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8775-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ubuntu.com:email,gompa.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jannau.net:email,jannau.net:dkim,jannau.net:mid,messagingengine.com:dkim]

The PWM controller on the Apple silicon t8122 (M3) SoC is compatible
with the existing driver. Add "apple,t8122-fpwm" as SoC specific
compatible under "apple,s5l-fpwm" used by the driver.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index d8f4f9ffe884..25ef04b60ca1 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - apple,t8103-fpwm
           - apple,t8112-fpwm
+          - apple,t8122-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
       - const: apple,s5l-fpwm

-- 
2.54.0


