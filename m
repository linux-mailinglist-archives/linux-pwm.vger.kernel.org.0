Return-Path: <linux-pwm+bounces-7846-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F7CF3B6B
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 14:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5561530096A5
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A033A9D2;
	Mon,  5 Jan 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PijM/cFk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCA33A03F
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616981; cv=none; b=lE35K5a1W00IA0Dy0jEwPLmfwtlHnPYSTgQLs93J/sGZAmlp2ObeUPBjATsH76P/vvM6+FuC/FpVbKhAjK0A3ift/qLKTiTnjI109c3wfJRclWiIqAXAPvQHEHWzl8uzBpxg6O5crCTAbRTqGGVuQZEdmUu4Tlx3545Xd+TuyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616981; c=relaxed/simple;
	bh=UzGlplN9hMJBDEgRgsBJzDppIssf1wZDo7F7rlGIARA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ce6rZVKBQH6YNTeysziHkeOKqvRAfyPUuRWo0BeQqotM9SVJof6gb6deoLwd/gJ2USGseOBWJNhKhtTQwSa5fbcAPEyEaSt7vEAZ3FuIA22fUYTQa++1kjfVL0zACLGEMvd+WeITmuJj5swqqTxTIiNCYw/kyZERPvz3g0PZd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PijM/cFk; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso7233137f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 05 Jan 2026 04:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616978; x=1768221778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aU5hvVbSIZ+0CKzUQKGtwRWDP0tIUkA5YvtKwL6kBRY=;
        b=PijM/cFk5KEV6LXxJQ5vkiy+4oYB0AYL4llqaAC6RF5qIYCZ74o6hilM3RhfB7qg69
         b/AH8zoHHbnALSw4sk6rLRPmdkuKuznm4GI6o5yJUzKl3eQ41Nd17i8ZTkIWm6HBvhNw
         fAzayed3FGr+q3zIL2HBPmz2VtC5jP3onR/aMU9qXR2ERtph9uJNrLF5Sr225o2P3xeU
         Iwpnsn9vuxd1FVUFJ/nXdy2a+lBxKmPWNrXnf8/DGYhCRGtGvUa7UQ7DtiZTguyhStg4
         MUbWh2j4rjHESR/q2ccrx2GSOKAGgzB6E7T+PHitIme33uPpZTPLSDQAxVX+8052gUiB
         pb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616978; x=1768221778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aU5hvVbSIZ+0CKzUQKGtwRWDP0tIUkA5YvtKwL6kBRY=;
        b=pfePbFPm0uH5sGawmHhnEhQJRWmG2Bg/l0m2oN95zj+Cl4EvDMVLWjTIeRsqPQwbvY
         MjdkACgx4gV3zSgRRdfp8SUQpttzxS9AurBaK5Af+5GcYWIJSRkfaOhlIzNXQCIc7uHG
         WfHoplIi53asoLGvaYhvntgBF4Q/pR01YGznHxil/QMsjY/7uUz1Fn9SmApE4kE+5CFA
         ylTzyPbP2INZqLWf6enyzbqc8qAJZz2A8dwwv1+8iDhafUiR3XsrVpwBJ01EBYaIvrQV
         eUsY2DZ2IBLT6A5zKhbcJqE0pnKFfzEY7rOn+PlDiWCBj5A3el6QVTDCr8YKYv2pz1QC
         asMg==
X-Forwarded-Encrypted: i=1; AJvYcCXANyzNduPh/srXEiPpfO92ePIJ+tEP2fjip3uP5TmlqzZ75ul3pPH9/fkz26U3Zv4o4jqIhca+zZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmjSHZT1IlsB6gRKUZOlCnbHjFLo0WuON74k7h6Gl8/WJWB1Q
	bAf0QDFVOyOQq0jWsNArvdp9Dv2NjT1S+JaCXRX4w8ctDqJky2n38mIG4Kd7tbxzgfIz3igm3jm
	udwUtwDbqw+YK3zdb4A==
X-Google-Smtp-Source: AGHT+IGC6w/pncYw2GA0wKwKDg6s/d5lSicuB0c/4Zy4kh1qNN8MAXi3s6OoIeFHVOEuj0zDz1NwdbhAfJULML4=
X-Received: from wrd29.prod.google.com ([2002:a05:6000:4a1d:b0:432:8535:4e3f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:220c:b0:430:f58d:40cf with SMTP id ffacd0b85a97d-4324e4c9692mr55748817f8f.16.1767616977864;
 Mon, 05 Jan 2026 04:42:57 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:27 +0000
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UzGlplN9hMJBDEgRgsBJzDppIssf1wZDo7F7rlGIARA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G8QUtoW9VTGtC8eS0Sh3JgTU5tkbqVimYdW
 8eVSeCqjBSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxvAAKCRAEWL7uWMY5
 Rg/tD/0Z8OiEdzydRZ/PQ+I7jFTjKmnYOtrj4ImZ0SJPK0WxCFQJR2irDOZfKhcYqanOp1ppg10
 TYeYoS0TiXAHOUxsrgcg5aHgog3owE/bGdmY94UXz6s8mpVhh+TSDowlnKEWUhBIRZgU5A4zHqn
 aZNQYU/eG67r55/yJCVYHpPPPAvhACbAUYIm1JrsuKyTfOk35tVrJFZ3l94+zANiAqPaWPxHA/t
 WeyOd0XWPLRPQInzYEGAQ15YBzMvXYXmHjrhZwy9JPbtuGb02xu0hNxYNbs4MDt1OUOGRogNvS+
 7uwLByBgwluySmLE1SmIa3mYianWs0JJHBfhHZr9swyXnj0NlJLrZb+4GxNFSOfhpE5HpLku/m/
 +18cJR0Uu4iL2G8yctT3guJ8Q+xQ6PKN9P7Zx5KdyP6vnT7D87He2HbDxTLtoOoOowDz7dfGElB
 vDO+dWPNff+p0FUPtIrP+d6KjQLSrQNjVQV3fpvwUBgjndvk2ir21zEqyn0ObTNYrtyjg6hPQAE
 KHe0QiQdO4tWt+DaZG7Th4LwOIsIn78TUeDNKRhZBkHQ9T+TQhiSzv0ISkfvQ4v5J0m4WCjgbsN
 S8V2ygd9v0uljg+4lQNzrckqb9Aa7277ijkiXW8aCtL9JON+ZX6gYnOFNCfKrMahLnKbzh7VC4i lPFfo6Y+k1Szhfg==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-14-51da5f454a67@google.com>
Subject: [PATCH v2 14/27] rust: pwm: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-pwm@vger.kernel.org
---
 rust/helpers/pwm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
index d75c588863685d3990b525bb1b84aa4bc35ac397..eb24d2ea8e748364f3e17dccbb6a92fd7f2514c0 100644
--- a/rust/helpers/pwm.c
+++ b/rust/helpers/pwm.c
@@ -4,17 +4,17 @@
 
 #include <linux/pwm.h>
 
-struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
+__rust_helper struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
 {
 	return pwmchip_parent(chip);
 }
 
-void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
+__rust_helper void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
 {
 	return pwmchip_get_drvdata(chip);
 }
 
-void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
+__rust_helper void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 {
 	pwmchip_set_drvdata(chip, data);
 }

-- 
2.52.0.351.gbe84eed79e-goog


