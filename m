Return-Path: <linux-pwm+bounces-5779-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5A8AA47C1
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C4E1C018D0
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 09:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47664221FBD;
	Wed, 30 Apr 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fR6wq6w8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBD231859
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007101; cv=none; b=QY4Bk9T1eTZALu6jAVAJ5W/78Zy6/U45jdIfDY1Sr4b6SlTXFaxxTFupFt7jBU9MFaoLAivcq7JI+6ZkHezVtAj+QQiOeiVFDLGgW6dB9cqYZahKthqS+2nSQDJuNU/EAf6C/qZtFMEXLHtBVVKAd2YGhYMW7jVQ1tqfoyYy45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007101; c=relaxed/simple;
	bh=wt/GV/pkMshoGMesRh4lIDdv+m3EQsqd7dNpcnh8PJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tc3ZHpWpGC7e7KV35INRDMqCp8+8pmtLpmUk1JETCeqougV94DKk0xiO9c/9om8mifeci5uXMHXBDKL6qL0DTnSm3kopB3MZs5usMzVPkgJEiLf/L3K7ZvAuBRG36VQE6NUdtm605SjwmsdCS6tqvyZB4SZbMI9bnwcS8YcFNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fR6wq6w8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so63486175e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746007097; x=1746611897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apjtAXv1I9txt3cw1nyZnrBi1ckaoQGJXeXPuGRHPKg=;
        b=fR6wq6w8BVGCcO0EdlnAYfZ0iedcS+BeCbR7Rj9j8vRL1sOSIqUK+jjZVmSQvge8uz
         enk8bB9qM+jihJM87VIVCOyX/M4EmqH8Z83/PHFvICmk18erBy/vbTS1uUryoHtTb9pa
         xHsoObjT7uMTA940rh6DXtsZvKiftuXO707vB8Ek92rkStbE0xF2ViT6ao1TuGWYxsPM
         A6NxREiGJFjKBRynC1rZVphdu6q+AD4X7T2F+54e9ouzjam4oMElI6FYcZWBwIOADStZ
         jAi05H6ZjQtcHD7ENH0++C+0jkpFJ9i0eZtsv0bhXrb6qKAXqqfHuzM/wYFMlAT/J3cR
         UvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746007097; x=1746611897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apjtAXv1I9txt3cw1nyZnrBi1ckaoQGJXeXPuGRHPKg=;
        b=eitZPU1YUx5pbqmWBoS4IvaXGQlUDObfJvpU9U27EFAGdnq5NpTf89GzqaEAzlYhjo
         /bElTF0upiB3jLY8HeClWDjzfKL6ll0mQlVz61PNi2OOSIgGGKPYdcRFjjq2lDsJsrUb
         hXiEz6ppjl/qnHOF6PVrS5nbT0+djhgGR/mFm7jJX6qYnD6iNGtaeS5JsOoMOUer9XC+
         Py27Ma0jo8AZic0NoPyHwTMV0N6Vj9C9ubV4rsuUVDrMPXkz2eudQ6mcmD5NnX0kyHhU
         FwY7ofk49np12VeAP6i2pPF52+IWWNp1G3asTvyfnK5T6cE7g9v004rqVWYfglxpJVGH
         T2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaQXNg9XsIy/Y/h958YrA0VmzBkkU0qmGNqpXF90YGiD9r1dQEvv0cxmeiOCGQCWImv0jFLucNwTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPQ0tVBnKQlFwLzHAmquN7BJKkjdlGU3y0LbpeXp9ZDrWwR9y
	SB5/HNrfw0ucbsiPhj8Q2/H04i6zq2UDUY+wsqKWC0Q0mnMNg06craAZp/EVx5g=
X-Gm-Gg: ASbGncvk26fzndgi4S0d3+RrIcE7+9lqVLJNlwt4f0uUfCAefon631aPF71pCihMmLv
	7reUrLhf8TazpORoVMQqFiZdUyFqC4HjczUBTj+u8VtfvnF1tsw9DATD4yjD/eCF38lfw/u51z4
	2PtQamQkuzcjZR1NSsh9Sbbp+BT2lsPZwqkBOpxSeAlYVfgQLBTXofYCYZU3uMhyUrEl0njslUb
	S3T4uVx3cl/KjMY3CDxyicawspFbcmFXOqFPsc5ZC/oOD3nCNzhKQjlsxpyzaZSG3M0p5TXD5As
	R6YksGsK//9wPMvx8bqY59QxH8MmIj60Ux1Obg/yEIfymGe4p2ZBrFONmViP6Vta87lQ4QJzoiH
	3HcEyWc4=
X-Google-Smtp-Source: AGHT+IHEnOmqmdJrRnX+Y1dbSuEsMHj4BAIYWaNReheY6FIqNiBIqaY9WubjTu+R8ppDVfweFMjDZw==
X-Received: by 2002:a05:600c:a20c:b0:43d:7413:cb3e with SMTP id 5b1f17b1804b1-441b23fa297mr11181125e9.1.1746007097418;
        Wed, 30 Apr 2025 02:58:17 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2af2a5fsm19634895e9.20.2025.04.30.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:58:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 1/4] clk: pwm: Let .get_duty_cycle() return the real duty cycle
Date: Wed, 30 Apr 2025 11:57:46 +0200
Message-ID:  <3db08ded39c09aaa5004b3b8b1238111f199e819.1746006578.git.ukleinek@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=wt/GV/pkMshoGMesRh4lIDdv+m3EQsqd7dNpcnh8PJI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEfQdZgGoFqqvkMOrD/AkoZmzebKJfWAyQNVQS Owmdtzwa3KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBH0HQAKCRCPgPtYfRL+ TrdiCACbYka2dIv8fv5ozvZGUA/EdQul32+i6NiiabAaZ9oZmJao5RHNHk2RqP3SvRFu6u5CPhE Fwz+I9w0nANmO2oxT+Mw3no+GgTeEZ23A+uiwZGPmpjCOG1+HygL24iNR3r7lDcQsbsgGVVP7u9 3TVGqZCrSgxBB+8PzaYVwskSl8mxvPrsxQvRTwCMui1gd3xxzq1MYSvMxU7fFlwn8bJP54wwF+P OnrY235VRw8qXbaq7t/HPT0YSiW8e4kVadoByDWkB1iVGX3pUm+HMTmFkyWlLsrMB4AWpvvTx2k LlTV5PaFagBYBhpYxfGMmSipaWbCUK6PaBP33qkL2lCQCKzc
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

pwm_get_state() returns the last requested pwm_state which might differ
from what the lowlevel PWM driver actually implemented. For the purpose
of .get_duty_cycle() the latter is the more interesting info, so use
that to determine the output parameter.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/clk/clk-pwm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index bd4f21c22004..429150bba8cf 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -48,8 +48,11 @@ static int clk_pwm_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
 	struct pwm_state state;
+	int ret;
 
-	pwm_get_state(clk_pwm->pwm, &state);
+	ret = pwm_get_state_hw(clk_pwm->pwm, &state);
+	if (ret)
+		return ret;
 
 	duty->num = state.duty_cycle;
 	duty->den = state.period;
-- 
2.47.2


