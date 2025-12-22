Return-Path: <linux-pwm+bounces-7822-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA2CD5F8C
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Dec 2025 13:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1AD43014D55
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Dec 2025 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B87281356;
	Mon, 22 Dec 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdIRGWpo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA0280A52;
	Mon, 22 Dec 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406293; cv=none; b=ebhMY3RLuElLHp9ehBMjuaVAm219PxNnKkn9PUGp9EZEzecUq9q2gyJ6qqZMuXn8jDw12PkTT9/G94bq+8SEDT42+t4ZPCqP5xMxwj4Edi0Uf420Aq1XgxiS3yW+hR/xvIR5sRpYc/F5fAmkJvBMpMZTphlteUwHQ9uPnKdkziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406293; c=relaxed/simple;
	bh=lnjqsDYEgCfO4ZddSccMgn38v9kLuF3K9z5CoiieAag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DvN7pUDjeuKvBMtPU0ItnLnw3tGyGAeTxpoiBjOl4BjIJh+YIAdpir9Shb/yOC4dPGuZisZZCN9sCBgC9BCqIh0Mtmca3kJWrg3095Qnih8Q5fEnNEShKAdRqwexeDDrez/9TMJQ1iRwIxGVU0IZGivly1psNPDdk2ht2wQkdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdIRGWpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DB1C4CEF1;
	Mon, 22 Dec 2025 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406293;
	bh=lnjqsDYEgCfO4ZddSccMgn38v9kLuF3K9z5CoiieAag=;
	h=From:Date:Subject:To:Cc:From;
	b=kdIRGWpo44iKVb+6ueuZw3guWj4LA077LyfYGHyIkzAq5xpOqjgAWIjqD7gbFNqrM
	 Ehe/Wh2i8jIagao63bqVU+P04x8KQhkQWLPomQ2p2KUDFmIL0ga9H8CVLlSPucNsnR
	 ZPVv7q3aJLHKjj/F7wi4b60TWGrAIi6DemJUBFMLqlb3pxaFOah4MTHdUKXKEVYP9C
	 yDmvxe0WHLXiWnXqJU5apUYL/G4/Z6Q07vNlqckBw5LsVRllTNtS2slYNH530Waunn
	 f4FjFsT76vv8GucmJC95j664jDhDIPdH4Sjd5KaVB7+6Kb7B0zjOqVIBMucUcuq1r6
	 yKqgHXvo6JMdw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:24:46 +0100
Subject: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqAMAxF0a1IxhZsUErdijjQGjWCHxp/IO7dq
 sMD970LhDyTQB5d4Gln4XkK0HEErq+mjhQ3wYAJZhoRlZPVq+UYlbO1rVKTaJ0ZCPniqeXzuyr
 K37LVA7n13cN9P6upymhsAAAA
X-Change-ID: 20251222-cstr-pwm-c9b9a4701157
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406288; l=1078;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=l+He6MEds9B9z2LyZUQ1+D0MyaUqDKaef7Is8IURDCM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFUXcXXV1sboqInuxMT5xqzVkmaROt+v/opgjZTA4adhR15BnVO+8Wv6E9k2catimkHqHF6q9iN
 u8aplJduG9wM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/pwm/pwm_th1520.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index e3b7e77356fc..8ae8f852ec02 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -22,7 +22,6 @@
 
 use core::ops::Deref;
 use kernel::{
-    c_str,
     clk::Clk,
     device::{Bound, Core, Device},
     devres,
@@ -327,7 +326,7 @@ fn drop(self: Pin<&mut Self>) {
     OF_TABLE,
     MODULE_OF_TABLE,
     <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
+    [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
 );
 
 impl platform::Driver for Th1520PwmPlatformDriver {

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-pwm-c9b9a4701157

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


