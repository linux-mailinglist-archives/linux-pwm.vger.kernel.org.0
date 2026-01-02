Return-Path: <linux-pwm+bounces-7836-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C56CEDFCE
	for <lists+linux-pwm@lfdr.de>; Fri, 02 Jan 2026 08:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D783004F68
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jan 2026 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151532D24A7;
	Fri,  2 Jan 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrVVpHmi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B22749DC
	for <linux-pwm@vger.kernel.org>; Fri,  2 Jan 2026 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340330; cv=none; b=Ev4LunAfs2JSvLvCWePNiKzrxW6nPA1mp+DS6wwnFR5Z29M0YdhdlPnsHk+Ya3EdfTFbZnO2VHflpZ+mJUGmL+KhhtbDetBJQr9aIlLcUMi5RxdpWaGAIsEMt+ffFOOLMGC4lBFD2g2NKiFwzyrma2Q/V0hYB2bFEC3znC3jzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340330; c=relaxed/simple;
	bh=Q6a+OL7+xR7FBhQ8E7EDUAYDtakbQh4kXFo9WQcfiXE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fDQyLFpsIFQvd5kLa+qIZ6ljqvfD8M4THjq26aQGqShkOrCOfzIEfYg9UE3/C+eYAlpXJbzrx+VqU0soNgYvVySUrXarzM3sGZ0SZ2NoFpLumSM411iM92XhUUKxdE67HoARiZWlugPXk7S/Dl01mH4y03vXh1a9lPTJCnx1pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrVVpHmi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59583505988so18173067e87.1
        for <linux-pwm@vger.kernel.org>; Thu, 01 Jan 2026 23:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767340325; x=1767945125; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2saNlD4YLRu5eDzJ7LgWITs0Np3bAKpvAb8pzQ1AsY=;
        b=NrVVpHmizjE4mIj20v6VAcd7NTVhEMALkpAcTCXES90dEZyexJTNWpR43TYVDKv3HA
         moTnaz6Gq7lvDdcJikRFn/yKGXDgKgmHmNUvAiGpoAMTBQIpBsneQ+7UEHFnvfDeRkGa
         xrXOKScaUEbgN0+ELz9owQ8aim/0vvB0KViXuhzqH7MXcKNEesC6e+C3notev6ghfVMo
         rgmShidTkH8kaPWQ4dnnnL+drtOOzsdhSWLXpZtsipDOjMfn4ZFD4Vo9335eUVoruYIi
         DHR0Qjjlkf93WFtx1hxyUTFLPMRiar32d54GIiDjStzyVmKw/GqbON/X5/b7MUpA24l2
         LF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767340325; x=1767945125;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2saNlD4YLRu5eDzJ7LgWITs0Np3bAKpvAb8pzQ1AsY=;
        b=sUnWXIgX6i4r0Y5JwGO5EkUXUlz33jDXXyxeFjEdJOEhD++fiHOpZ8TssPDQM5W6XM
         YfsFtvEsYjSIfEhs0LkCCUkuSEKS/X0Tunj97zoBAkmbqquQDxRrq+9Uxz0XNnjxknWC
         uMIU5xx6FNYtGxiVN8HfW2c9+UV9IojxIlMiMnaWp+XBT1OYBr+MEymHJJKceusfai+y
         IrnXAwGMMI2F4r0+9kWLCY68DANbbbx32C2QiMh6euvMdhhBuoHKjqcvRRvaTqaXOiKs
         SiRsNizY6WjqYVp5HMAEyQryFHzgYX8llwP0YcmyfYIVptz1QWlLlYplq/vAm/jN6suN
         LKIA==
X-Gm-Message-State: AOJu0YxGYoWZaPYvda1igyejBlJJmWcC+CYbP0fVB2gW0oeazSFpIBY5
	pV9Lba4hNKe/fJgXTBSrJckzNUwWkufDbdD8Jv8IMFD9Wh3bVRduB0az
X-Gm-Gg: AY/fxX51xEymM146yJCVwH95CXaMnuvpx4Agw3WjySYHt5fnOCUwXBUq7RYy//+DOxa
	bNIxfOaeKph0u6BC9GV3H6CFEy+GV19kvpID+hh66/AEorrp1JBxkKyZRP4SQ9bAhhWTW32AlJD
	iYjnOGvIWKP6Sjd8x9T5FrlblslZS4IaRGd0KxODzO69OAkqXtfGM+6wp1ZmsK/jak7bac108Sx
	S3kNc+1IbaBnPkjlEHcxcVO4+JYRLIiKOTDY6CiKolqh68Sl0QHfAqppqBkVjr0I4w0IrkuSPVY
	CutjHCKT5ZlV59hYZjP6lVC7XL+jEueRaIvHAtbDoaDXYpyyn0kkJXgkSQ329O5A6jFny4bZbtu
	HQRzsvdDf9hZjn0ozeCrw1WGGMDYK18If0ItwVIHXFbUZRNGolzQ7UDiAoFVi8bDAF2rgnYKsFN
	7TyjiANXat4QHwBGtVp+jRZoMWDt37DcsqnWoOAhtFo1WV
X-Google-Smtp-Source: AGHT+IFHAcifTVnP6L978ufKvxPiVZE13KxXx3nNBPeRryrxrvaahWms1Vw2tRm6qz5m0DYaU/2MgA==
X-Received: by 2002:a05:6512:12c8:b0:596:9ebf:25a2 with SMTP id 2adb3069b0e04-59a126ea38bmr13792586e87.19.1767340324877;
        Thu, 01 Jan 2026 23:52:04 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com ([83.245.248.13])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de35bsm107688061fa.7.2026.01.01.23.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 23:52:04 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Subject: [PATCH v2 0/2] rust: pwm: Fix init error handling and tidy style
Date: Fri, 02 Jan 2026 09:51:40 +0200
Message-Id: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAx5V2kC/23MSw7CIBSF4a00dywGaOXhyH2YDpoC7U2kNFBR0
 7B3sWOH/8nJt0OyEW2Ca7NDtBkThqUGPzUwzsMyWYKmNnDKL4wzTdaXJ/GZNiKNU50w1DHVQr2
 v0Tp8H9S9rz1j2kL8HHJmv/UPkhmhpBNKtpZpIbW5TX7Ax3kMHvpSyhe8uTOroAAAAA==
X-Change-ID: 20251219-pwm-rust-7df846d0f183
To: Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767340323; l=984;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=Q6a+OL7+xR7FBhQ8E7EDUAYDtakbQh4kXFo9WQcfiXE=;
 b=/0urX8Mgu/X3gLbseyGwjoiJE5i3Z41wlNFwEKMo5r8VPH9v9yim7Wp2oJ9A6/sujHEX/KA8h
 6lFDJAv/o0fDtFMvrTtss8G6Mv+iqg1WaGorxcYWm8dac9Ce7JsT99V
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

This series contains two small updates to the Rust PWM bindings.

The first patch fixes a potential memory leak on an error path during PWM
chip initialization. Someone needs to decide if this goes to stable.

The second patch is just style-only cleanup.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Changes in v2:
- Use inspect_err().
- Reword SAFETY comment.
- Reword git messages.
- Added Fixes tag
- Link to v1: https://lore.kernel.org/r/20251219-pwm-rust-v1-0-46873e19679d@gmail.com

---
Kari Argillander (2):
      rust: pwm: Fix potential memory leak on init error
      rust: pwm: Simplify to_result call sites and unsafe blocks

 rust/kernel/pwm.rs | 53 +++++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251219-pwm-rust-7df846d0f183

Best regards,
-- 
Kari Argillander <kari.argillander@gmail.com>


