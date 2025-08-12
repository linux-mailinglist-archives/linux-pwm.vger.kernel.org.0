Return-Path: <linux-pwm+bounces-7022-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818CB22AD4
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B518837E1
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DEF2EB5D5;
	Tue, 12 Aug 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSX2XH+P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA82EB5A7;
	Tue, 12 Aug 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009347; cv=none; b=EXho/2vcBSzIApZ2269TTptsW4vEscw0fvdtg7Y8bi5zfy0TGk767T8h1Xpw31UZO38+66+aCCdBwZi6ELJgqhJBg22N10CVPTR+TK6HVixPTXXWzBGT3NtOPtc/IPaer3ojtOy9mb5HxFungS36CCwpNMKZPWqmjX3uGYfZVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009347; c=relaxed/simple;
	bh=RUaz2F7M+J8suIFZqnO0eXnGJrhkRbwORESw+0/OzrA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=apCcqDiyShzXufYGSe+x9i0m+6CEh4xXtT6/CbExYpMkRMndnhnEizJibwyhjDejUoD+JhLyXYE6IgYzZdWiu+k8drEjEmp+8HyzyqPC9U4RiDta++tiMGVoNVaylkjuOxEUiPLyPMM0axugmLartHm4TUyXXJicafkRTJefy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSX2XH+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0892C4CEF0;
	Tue, 12 Aug 2025 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755009346;
	bh=RUaz2F7M+J8suIFZqnO0eXnGJrhkRbwORESw+0/OzrA=;
	h=Date:From:To:Cc:Subject:From;
	b=RSX2XH+P10pKNs0r8n92lYyeDmpMNovIKyedzkNNNFy05oyRj/Ri1NTZyQv6V9SmI
	 0fWwaDTNRwFdfTh3X9NdnmhTBwhhrzBF8fctIZ45I+hdiVcMB/oPTrLOiVIqBMRvbb
	 0oIpVX5RgYPKjfEh0haxl9sgFRQVVQwWpcQUt5HD/tl5QTaNjuC3itOOf17yWWXkvK
	 jGwqTV9FXj0/8Rg8Z4Q+PlfSnczIMnWP/kWIj2UhpDvd8T7SjLoug8PFdwyi6AXj0W
	 f2QTEJj2YW/Z6AkByTNzszY+HsKDkn/K962FPFldePiAWprcyMxfv6e5XtydRoGlhN
	 7Hwp8D+EdrxkQ==
Date: Tue, 12 Aug 2025 23:35:41 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <aJtRPZpc-Lv-C6zD@kspp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix the following warnings:

drivers/pwm/pwm-cros-ec.c:53:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pwm/pwm-cros-ec.c:87:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pwm/pwm-cros-ec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 189301dc395e..67cfa17f58e0 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -49,10 +49,9 @@ static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
 				u16 duty)
 {
 	struct cros_ec_device *ec = ec_pwm->ec;
-	struct {
-		struct cros_ec_command msg;
+	TRAILING_OVERLAP(struct cros_ec_command, msg, data,
 		struct ec_params_pwm_set_duty params;
-	} __packed buf;
+	) __packed buf;
 	struct ec_params_pwm_set_duty *params = &buf.params;
 	struct cros_ec_command *msg = &buf.msg;
 	int ret;
@@ -83,13 +82,12 @@ static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
 
 static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, bool use_pwm_type, u8 index)
 {
-	struct {
-		struct cros_ec_command msg;
+	TRAILING_OVERLAP(struct cros_ec_command, msg, data,
 		union {
 			struct ec_params_pwm_get_duty params;
 			struct ec_response_pwm_get_duty resp;
 		};
-	} __packed buf;
+	) __packed buf;
 	struct ec_params_pwm_get_duty *params = &buf.params;
 	struct ec_response_pwm_get_duty *resp = &buf.resp;
 	struct cros_ec_command *msg = &buf.msg;
-- 
2.43.0


