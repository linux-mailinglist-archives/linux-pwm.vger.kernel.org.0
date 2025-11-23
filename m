Return-Path: <linux-pwm+bounces-7666-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A57C7DEA9
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0955334D69C
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D42206B1;
	Sun, 23 Nov 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1uMvzGw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F013B293
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889933; cv=none; b=NulZ/QXI6iMK1zYZDl/yjF2TbGl9aEIEjMaFH32R7DLEkgVlxRObDgJnPHW4yujy+6y5N69J8JZESMRWw+0Pj61mz1jk12orwbduttNAbhyXHeI3OTIRJJE2caLlJX+bbuqLoRMCf4CTnBKOtIseXf4JlhllQJ6zNvW8CiedRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889933; c=relaxed/simple;
	bh=nEqPnpenHeMQyt4BL5b+1nS5H2Z7JAz6A5D7rnZ2cp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9CaigBs/ap7OHCxDvIfN9U2xqHc4HHDpXlIG3py1XFvSy9yB4hA1fLeSCn7BNuNTaXXCN/33C/JIBJjwtB8VhUq+FbS1Az6+bAGBtd0BDQwBDswd7NfS+AA37NlO/ardN7y62LeuV2aK7mMC3hvHBkz0kMkgj72n0Y+N7EAX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1uMvzGw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29586626fbeso41366505ad.0
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763889931; x=1764494731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=977npvamVvdSn8Hrj6nV2vV28cG+wMk/irqNnaoU/Xw=;
        b=E1uMvzGwjfY9YUY80WZCRybsk4ehNF2NHpzuza03qbgc2GwiWivPL0cReYqRCno3XT
         I6mANquK1yNeeAAjruffs1bPKW9BpBh/TedixwIyNxLtOQILKT4jSN3dFjD5YR+w8dP9
         jD4EIFU7nPFTQOp66uceJAfuq932KGlQl+nM/G4ZpVWOsJEIzW6d08Gk4qE+T0RE8YO6
         Xam6aGoyRMAl81Os4tMAaqLbC23l9U3ASCLhWtk4YrOR5Hqp4EIl8CbdLNmCac0hFc8Z
         FZy/iBhDU5Fw9as3PdtDHUwkPO53BobfVxRGhf1zMwKwMDtxw0WSxhOCPgTVIAHeY//z
         9Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763889931; x=1764494731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=977npvamVvdSn8Hrj6nV2vV28cG+wMk/irqNnaoU/Xw=;
        b=q4nccZjBWURFW14GzaUeRYiAm0FkCEGMJN07cW3eQX2BQ0c5k0opo5engreIMQQpeB
         UkhLlDgqVKK4Fg/+k86f9iTxNiBpnEOV8vMaODlxcKJtF3HJIq3TUYVtz5IQX3diBfZV
         Hb9e4S2cpFpQ9nlhIejqyT7fJ+El8TCmr489+FvtygXaa+mnJBQOwErTfvN2b3LRx31m
         toSxrSNvo6sRr+pWpzbcO1MACf5cjEyZXEQN9mJonVmA2QX7Q91Pk6nnJibLXjeqPql9
         ymIUVtvleD+E4cPNB1wJJ9VSAV00Nb5l/SnXOno4A9kcTSdC007OY9Ix9QPc6AMC8ejo
         lBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCRzsnZiAnH8sKoPe7eKa+HYcV6Oq5NQYzUk+t4IAPNz4NnPw9P4e/dhRbXFsbjPXR9C41BR1JaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCSa58FvZjrkZJ9JwL/jtyozM1YKjvPjP3own6Wq2hMiRDIE3N
	y+1MzhSr1imeg7oxdrVA4kMB0rgEe9i0BLGFfjLgchiWHfroAwmyfKG2
X-Gm-Gg: ASbGncs0kRBkZKutT/nt3akNhfjs3G7OQ2O2N67guofCcFJ5nJwViHeHJabiHXzbYYF
	hB9WwIPVk/RdHwk/8adRaJNbBW1PhFn3lZKuOAwKuIuEUELYFQmnePObGcfQYC06KWptBKnj2sD
	YGTVCHkUR0dP9Mcy+ky/UElH6BBuKB0CNl40d8+38Gv8q0MS36Gw8LTWoQ8Y3yUdGdtI/b6ECro
	sYfCIt9TxSQsPy7relRrhjvWGnScraT5J7LFeV73eutMyNfdJGLr/2RZoymns2O3EiZVtJGi2z/
	qFhq/5rEEdz5JBpAqB3gJYfC1ZttGie+VKLBnVzzYI+Gke00JSistSUAAFONVXQl6Hysr9R1xmV
	NipED1cBTf6yi3G5EHiQtkEVt2VUK9ke1iEMDbNOapF4vRhQSvHSBX1aQh3RnyW+lxBDO7lvrCh
	t1tNzEtx5YnqAwnJIHHdCZCn8ncQ==
X-Google-Smtp-Source: AGHT+IH0c6lqi1+YOT+atVR2GQVjdlkn5EPFXDoVAJCKagGeZwAimktqjcIQnMFOvKx8Iio/IO02PA==
X-Received: by 2002:a17:902:c946:b0:297:c0f0:42d7 with SMTP id d9443c01a7336-29b6bf5f050mr110076125ad.41.1763889930982;
        Sun, 23 Nov 2025 01:25:30 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:25:30 -0800 (PST)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alexandre Courbot <acourbot@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 00/10] rust: refactor ARef and AlwaysRefCounted imports
Date: Sun, 23 Nov 2025 14:54:28 +0530
Message-Id: <20251123092438.182251-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the import sites of `ARef` and
`AlwaysRefCounted` in the Rust kernel code to use `sync::aref` instead
of the previous `types` module.

The refactor to `sync::aref` from `types::` was introduced in the commit: 
commit 07dad44aa9a9 
("rust: kernel: move ARef and AlwaysRefCounted to sync::aref")
link [1]

The goal of this series is to complete the migration of these
types to `sync`, as discussed with Miguel Ojeda [2].
The last commit in this series removes the temporary re-exports
from `types.rs` that were originally added to avoid breaking the
build during the transition.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
[2]: https://lore.kernel.org/lkml/CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com/

Shankari Anand (10):
  drivers: android: binder: Update ARef imports from sync::aref
  drivers: gpu: Update ARef imports from sync::aref
  rust: device: Update ARef and AlwaysRefCounted imports from sync::aref
  rust: drm: Update AlwaysRefCounted imports to use sync::aref
  rust: kernel: Update ARef and AlwaysRefCounted imports to use
    sync::aref
  rust: kernel: Update ARef and AlwaysRefCounted imports to use
    sync::aref
  rust: kernel: Update ARef imports to use sync::aref
  rust: kernel: Update AlwaysRefCounted imports to use sync::aref
  samples: rust: Update ARef imports to use sync::aref
  rust: kernel: remove temporary re-exports of ARef and AlwaysRefCounted

 drivers/android/binder/process.rs      |  2 +-
 drivers/android/binder/thread.rs       |  3 +--
 drivers/gpu/drm/tyr/driver.rs          |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs |  2 +-
 drivers/gpu/nova-core/vbios.rs         |  2 +-
 rust/kernel/device.rs                  |  4 ++--
 rust/kernel/device/property.rs         |  5 +++--
 rust/kernel/drm/gem/mod.rs             |  2 +-
 rust/kernel/i2c.rs                     | 10 ++++------
 rust/kernel/pwm.rs                     |  3 ++-
 rust/kernel/scatterlist.rs             |  3 ++-
 rust/kernel/types.rs                   |  2 --
 rust/kernel/usb.rs                     |  3 ++-
 samples/rust/rust_debugfs.rs           |  2 +-
 14 files changed, 22 insertions(+), 23 deletions(-)


base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
-- 
2.34.1


