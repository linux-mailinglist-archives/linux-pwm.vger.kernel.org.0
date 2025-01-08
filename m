Return-Path: <linux-pwm+bounces-4553-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9137A0619E
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288BB16718F
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E491FFC60;
	Wed,  8 Jan 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQcrxRsJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E11FFC67;
	Wed,  8 Jan 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353150; cv=none; b=e0sdq+2xu6yjQKwksM7iJb9zE2OGSjslLD6KHNqX3XYtAGfT5+md2lOt24YUUk+BQltbdmUyYTwJRN9O8pvg7cJ7SYJC36sRfy1bJblQXBUkeTFiSItdK/o4XixKrBVKJwFyn9OCBzPFNe6PH7LkiCljaDFii0DnA2rc2pZnv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353150; c=relaxed/simple;
	bh=OEOoebtmvk4gaTVK8gGNSBe69+Ccofkqa84T28KoINc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDmYj6u1IsnzkTm70N/mxSB3pbXoBzCC0LJubp1cW6BQU3yX7WvBYVmdbsYYzcngpdMT/HFBjMh3RVJUBx0AR15N0n4xuKMrmW/obxQXZSeDRrVtS371/VTf221ffH1hMLhREwRphGEir4+mkF8X8lRmRn8Ki4OkXzSfXJspP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQcrxRsJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AB2D6E0006;
	Wed,  8 Jan 2025 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736353146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oeofzVxYMxPZg6bEBvKaS+A5mI600/iVxui3ZyB2Tdg=;
	b=mQcrxRsJ9/16exlNqXkrGmEiYrHZq3DM0JztsHAmumy42i6HuB6UzA/4HePFPKCGtKGTZV
	BiUeLr/TXXX1ziTYGoXlaGQ8hDeJzhSWmzSwtvs77JBgn83ZFswjQ6Ks9iO6oF0V/5a68d
	de7iS1UY2aT00Yyo6YazKxyMGM2H2JeNw0FYLwShxqfV4D5a6WhzsBSWgwrfLFQUeLFDzI
	X5iKQDWzqvlBuAfuw0P6YMkt0zP5cLl6to+e3uSbfL7a+ZY34z8ZNgsCHU/0sDDPJ1WHeQ
	PCIf43EMC/BT4ZUHLNX48dQlkPd9GS3rgwLFse506Y3aTap6my1whByjRm9FoQ==
From: Herve Codina <herve.codina@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 1/1] pwm: Add support for pwm nexus dt bindings
Date: Wed,  8 Jan 2025 17:18:53 +0100
Message-ID: <20250108161853.431915-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Platforms can have a standardized connector/expansion slot that exposes
signals like PWMs to expansion boards in an SoC agnostic way.

The support for nexus node [1] has been added to handle those cases in
commit bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through
a nexus node"). This commit introduced of_parse_phandle_with_args_map()
to handle nexus nodes in a generic way and the gpio subsystem adopted
the support in commit c11e6f0f04db ("gpio: Support gpio nexus dt
bindings").

A nexus node allows to remap a phandle list in a consumer node through a
connector node in a generic way. With this remapping supported, the
consumer node needs to knwow only about the nexus node. Resources behind
the nexus node are decoupled by the nexus node itself.

This is particularly useful when this consumer is described in a
device-tree overlay. Indeed, to have the exact same overlay reused with
several base systems the overlay needs to known only about the connector
is going to be applied to without any knowledge of the SoC (or the
component providing the resource) available in the system.

As an example, suppose 3 PWMs connected to a connector. The connector
PWM 0 and 2 comes from the PWM 1 and 3 of the pwm-controller1. The
connector PWM 1 comes from the PWM 4 of the pwm-controller2. An
expansion device is connected to the connector and uses the connector
PMW 1.

Nexus node support in PWM allows the following description:
	soc {
		soc_pwm1: pwm-controller1 {
			#pwm-cells = <3>;
		};

		soc_pwm2: pwm-controller2 {
			#pwm-cells = <3>;
		};
	};

	connector: connector {
		#pwm-cells = <3>;
		pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
			  <1 0 0 &soc_pwm2 4 0 0>,
			  <2 0 0 &soc_pwm1 3 0 0>,
		pwm-map-mask = <0xffffffff 0x0 0x0>;
		pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>
	};

	expansion_device {
		pwms = <&connector 1 57000 0>;
	};

From the expansion device point of view, the PWM requested is the PWM 1
available at the connector regardless of the exact PWM wired to this
connector PWM 1. Thanks to nexus node remapping described at connector
node, this PWM is the PWM 4 of the pwm-controller2.

The nexus node remapping handling consists in handling #*-cells, *-map,
*-map-mask and *-map-pass-thru properties. This is already supported
by of_parse_phandle_with_args_map().

Add support for nexus node device-tree binding and the related remapping
in the PWM subsystem by simply using of_parse_phandle_with_args_map()
instead of of_parse_phandle_with_args().

[1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v1 -> v2
  - Rework commit log

 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9c733877e98e..4a7454841cef 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1707,8 +1707,7 @@ static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 			return ERR_PTR(index);
 	}
 
-	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
-					 &args);
+	err = of_parse_phandle_with_args_map(np, "pwms", "pwm", index, &args);
 	if (err) {
 		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
-- 
2.47.1


