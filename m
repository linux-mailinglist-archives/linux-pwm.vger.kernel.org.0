Return-Path: <linux-pwm+bounces-8239-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCxONxQvsmmzJQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8239-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2026 04:12:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EEE26CAE2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2026 04:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9A1B307AFE6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2026 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE53383C9B;
	Thu, 12 Mar 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKz8Xapf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002E383C75;
	Thu, 12 Mar 2026 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285066; cv=none; b=fG2uGATn2y0FQqB/37KkvKE+vWD8BkvCqspkVJ5OiP09g0BPoLXtHPt3qdknzbJRXR3b/3EiupvObmXp5uCUtGyRn6IcQC+AiM57jXeWWm41oQz4lHr2xUe1m6qKSILlzWjx0KrId8XL9jMjEtee7dlvgtDdRGIIOHtceOOKYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285066; c=relaxed/simple;
	bh=UUZhraH0YUGW35D2rSEAdEG85NqMBFjKecKBQX+oMr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EVMtNnEx244XAOHY7tjrf5CVgi9OWPFMWgKKngMgqrd4g53frkXviNPqM7zUX4o4xRh4n8jFbkBbZbZ4objNevmD2WqDgPgqhazPnlTz4hXocwUp9MWVMa8od+oOLpX3k0SXtIChf7GOyLuC5jZZntjg6AYY533lwvwIntdnm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKz8Xapf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABEB4C19421;
	Thu, 12 Mar 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773285065;
	bh=UUZhraH0YUGW35D2rSEAdEG85NqMBFjKecKBQX+oMr0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UKz8XapflfrSub+/bSq3ZR60btvI3qadJidWzovh70eir2oDBJUuFLvljeS1rpDl/
	 grlXRRPPOL2SF1A2btbJQu78APALLNbDwmRcueTlfIo24p7q5GQbJpSOIDNFNwQgO/
	 MdvC1JfH/BDrl0k32c4FIWWOX7o12kdK0JLVGqBxvMk/FIGINKlq6DI86SVEZ0Jh7d
	 AFjGTLXZfy7N1MNf2U+JQ+DOjRrQByGG4RAdVygZJ5yGOwsQyPKcQ5Pm5KgCSUi5dB
	 /+00l3KWnrgCHY1s8jN+v4sq6H+oEsUfkklUj5evaiMEG2RT4OuTa0u2ys1a3dpJGM
	 PYvBUtxvxi0jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D6E103E300;
	Thu, 12 Mar 2026 03:11:05 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 12 Mar 2026 03:10:28 +0000
Subject: [PATCH] dt-bindings: pwm: amlogic: Document A4 A5 and T7 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-pwm_binding-v1-1-515cb65add98@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKMusmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mj3YLy3PikzLyUzLx03cRUCxPz5BSDZHODNCWgjoKi1LTMCrBp0bG
 1tQAUhH9uXQAAAA==
X-Change-ID: 20260312-pwm_binding-ae847cd0c70f
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773285063; l=1236;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=rZ9QHTXWFZRqKa+SSVPHCPcz3e3bqLwWkz+549SNkJs=;
 b=nCAlE7mTXsh7iJIhsnjsTzTdnSzEartep4/j6/p29SArKM/1M981N35XrdR0lQe8Y3m1odx6y
 oopsOuPC/llAFRibGywSNp5xR7kFauRQA6AMKg1MiqbaJAHmZLQMjDA
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8239-lists,linux-pwm=lfdr.de,xianwei.zhao.amlogic.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60EEE26CAE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document amlogic,a4-pwm amlogic,a5-pwm and amlogic,t7-pwm
compatible, which falls back to the meson-s4-pwm group.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
After the clock module is merged, the PWM node will be submitted
together with the nodes of other modules. For now, we submit the
PWM DT binding first.
---
 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index cc3ebd4deeb6..c337d85da40f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -39,7 +39,10 @@ properties:
           - amlogic,meson-s4-pwm
       - items:
           - enum:
+              - amlogic,a4-pwm
+              - amlogic,a5-pwm
               - amlogic,c3-pwm
+              - amlogic,t7-pwm
               - amlogic,meson-a1-pwm
           - const: amlogic,meson-s4-pwm
       - items:

---
base-commit: e3194dfb772304a1b7ca3bcfccacefec3468b7bf
change-id: 20260312-pwm_binding-ae847cd0c70f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



