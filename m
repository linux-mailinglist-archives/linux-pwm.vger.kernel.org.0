Return-Path: <linux-pwm+bounces-7764-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D903CA8F74
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Dec 2025 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D8630EE830
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Dec 2025 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4E3590AB;
	Fri,  5 Dec 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB4B8ACn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81509358D30
	for <linux-pwm@vger.kernel.org>; Fri,  5 Dec 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960045; cv=none; b=VmQzWbYMPAR4IPKUnZZBQSJZ5Ri4eKXiGEjsadQXDU+9wPj3Ep5ASawo6N2bv+OMq5DWmA0z3sVS9m5WPcjvbJXCFiwf574Uft2BiiTmaI6yDWf8mmFsnUI5jFL2cnbDHatVLbHISu+CR1ZnnpzVwTjiDW/epUOdufNbABzPq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960045; c=relaxed/simple;
	bh=6Yy3IShQVWKoUdXCDZD3yBqKU2764SqgOZHs7jYW65g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BI2z/EGj/KkCmJ9GPedPfG8V9EH1gxasxKhUCbISFd6Rk+IJJCON6GNs1JuiwYL/z/jtCezfFnczVVKVMXwOZcpdPFo7hMOdZ1HyMdpRbhUFyJqPcMHsuqVp0h0Rpc6KiqrBM9vodnRMRBaRcCF53rN/VhVCZxXaqqAZOz3MAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB4B8ACn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so2648351b3a.0
        for <linux-pwm@vger.kernel.org>; Fri, 05 Dec 2025 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960040; x=1765564840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx4zuHCdfmsBvfViSx4dewQ3NC0pwlIv6go7qc93ekw=;
        b=OB4B8ACnPwttjampNMBOyr5SQc3Lvq62ehcw0tv8++5+w4VkufFKGOxcDXbCKO0ZfO
         pqHpYswzVY/GbBPI+w8G4ywayCKLapa5R5RRM5i2PHXKwztAC+JznM87b23IhWGIJEVT
         yG9433rpC9RO7QrY1GfZ+wpMP2+38InsAw4QmJFd1Bjsg6AGdaT1bZaBxwH4CGQ4fMcE
         aId8rOKhpwqC3YyolpgTi+TLuRH/VfgLCHC0pVdT/YZ6awxPOzVVMl6bTAP733KmyNnW
         M7SgQvULVcIthAa8zUMJM8LwpiUB1HemuP45Sq/wLzODq6jNbAW4kOyCRQJSdAnQZsSt
         +pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960040; x=1765564840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gx4zuHCdfmsBvfViSx4dewQ3NC0pwlIv6go7qc93ekw=;
        b=oBuxtFthzYHW0EpmY8U7FFTsRpk+aOzXs2bBekCJowxi26cQp26C3SyWTDvT9iv/vy
         jRMRLct0Ec3cTsb9JTUrqkY6itbm0kEuieT1SC+zwjiGIz5B2UhsWA3bLUOOtCZSwy/a
         H53vjcpsABP5ZSoJxDT5DBuyznNqmKJ2bOjTFA8YnC7M+nBxqBenINoGTkKYGUIBua0V
         X9goPybYnT9bjsM+klaYoago2sWiRqrRY9FOAW/dx8jvT9gKuYXLGLkZP3ausnlwL1UH
         VBQ8AWlccla0pBIY8Fh99rFmTApjb5qF4YRRFy+lHwE0FzTz946Y8Oj34JC1tb5BcX2+
         YK2g==
X-Forwarded-Encrypted: i=1; AJvYcCWHzj+T60ncjrfR08sWqXcx+6m3sQC1h86MzQ+wdpAbCqJ2NKuuG5camo3AvmevFqxCbeHUyV6tgwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaIsvVmXo9eAVPmaD6luty9gB0a5h1perzA/GDJ5rToiH9iy7
	T2GpEFcEn145nkDx6vn5+e530bK4mfHyrYq3JhuVPdvGV+FUKBFLVKHh
X-Gm-Gg: ASbGnctf+64WMG/FALHQkO+8clc10XFMbzhmDOECLwcK+GAnxODQZK9VI+7YAhwyDAX
	fz+1OvWpTS/wdf6dU0EAUrDVWTcFnhYqO9Q8WXJXkmfKR1m+EuscbvyJkRCfvh/vgcK2V3qidTt
	yKKPkRUPyZg5J4kcHbXWsNhcWc6jSn4mubQpoXPnlyZKsYlRsf0gm+50GINlojEXwQxR0uk5foM
	OmH6JcRuYo6gPh0T8fNJPZF39+8jPIcz3+ULvtC6W8AuuDE0+AnFcLVqKJbWNgz8FTuuMh/Aqnp
	n3GqABgq71T7ky0Ks3ixyFn4SFicbNTCXTD8HAMqnlgJhSaV4gn84pl5T2/47l7Z+0SDXyZK3Rs
	VaPHWVFwLoZZHbudPEmdJa4ppMpKlqMjTLCckokCb6oRXlmYzf9lyZNJm5LYBV3VyONWihWo44n
	fsoRrkWelrugen+mrGoluyYWD+/w==
X-Google-Smtp-Source: AGHT+IFdaIOl2EVfDf53MnHxu6h2Csp/9+fkL7qdsbkngVF7MJLua/LR1xBA2DmFila+UaeQfEKpNw==
X-Received: by 2002:a05:6a00:ac3:b0:7e8:4433:8fb5 with SMTP id d2e1a72fcca58-7e8c6cab76fmr135748b3a.61.1764960039751;
        Fri, 05 Dec 2025 10:40:39 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a0533f08sm5952079b3a.23.2025.12.05.10.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:40:39 -0800 (PST)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 05/10] rust: kernel: Update ARef and AlwaysRefCounted imports to use sync::aref
Date: Sat,  6 Dec 2025 00:10:23 +0530
Message-Id: <20251205184023.7230-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1b7408c5-64a8-42f1-92ab-dd90a883c1a4@gmail.com>
References: <1b7408c5-64a8-42f1-92ab-dd90a883c1a4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Igor,

> 
> NIT: This module already imports `AlwaysRefCounted`, so please use the
> imported name instead of the full path for consistency.
> 
> >       fn inc_ref(&self) {
> >           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
> >           unsafe { bindings::i2c_get_adapter(self.index()) };
> 
> Thanks
> Igor

I apologize for the overlook. I was just focussing on changing the path. 
I'll make the required changes and send a v2.

As this patch is part of a series, am I supposed to send all the patches with a v2, 
some have been acked by already, hence I had the question?

Thanks and regards,
Shankari

