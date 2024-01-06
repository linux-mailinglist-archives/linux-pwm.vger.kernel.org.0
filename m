Return-Path: <linux-pwm+bounces-680-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A32825FDA
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B6FB226C0
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A37482;
	Sat,  6 Jan 2024 14:27:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF67494
	for <linux-pwm@vger.kernel.org>; Sat,  6 Jan 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM7df-00074I-2v; Sat, 06 Jan 2024 15:27:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM7de-000pKj-83; Sat, 06 Jan 2024 15:27:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM7de-004149-0W;
	Sat, 06 Jan 2024 15:27:02 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
Date: Sat,  6 Jan 2024 15:26:55 +0100
Message-ID: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Mriijo/ycRG5GCW7t78UJUceaYg2G2vsBOIGskK9hfU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSZyXrPlrj8FroT7dD7g+OcjerjDd9UjAWXcfDVT1sY9 CfrTYR3J6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATqRJh/1/QYJ4cvN3C5rHD TL+dfGc2T837k7jAMN7c2l0uQuqOI48JwzFDI+Nie52rv/pfh1W7mOUdFjymoxTd1uC91nGGdY+ fxMZ73xm7mL9W+Zqs5f0m+Gf3MiZNi636PZUyi3OqMnyUOx1XtN9+s/ijw4rY3urLd+MM+Dr0Qm 8/iuY9xf/MqfTpQhljO/soOdGKAJXV4ZdrZqgeqTzPebKBu/KW/4sJeg6zrs+vWSB3ed8On94d9 XIXHFeXe0y6ln5+VuZ7T5MrOuHNt59ekZ8SeZbt0Y0ds+vLWJRn7L88h0Pg8/lb9569D8r0ieVn E998qOzg1bKmmxbzqn7WrApjWrdwb074yQWdKvMs8wK1AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This fixes the dtbs_check error

	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#

in several device trees.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 65bfb492b3a4..031a448aa2b3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -45,6 +45,9 @@ properties:
   clock-names:
     maxItems: 2
 
+  interrupts:
+    maxItems: 1
+
   "#pwm-cells":
     enum: [2, 3]
     description:

base-commit: d73f444d06fb8a42a5c0623453f3ea1fe9880229
-- 
2.43.0


