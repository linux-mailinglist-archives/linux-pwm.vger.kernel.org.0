Return-Path: <linux-pwm+bounces-7814-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F540CCCD61
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB663075674
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112B34B180;
	Thu, 18 Dec 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyVC97uO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63E34AB03;
	Thu, 18 Dec 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075721; cv=none; b=XgX2XPSs8zsa/hOptRpidYDIGZfR6pjZ4Xkzl1NMDThz4EfnDxgRaCLPawNytL+KUou+2aafkTSLgSfrUzHFyc+QSp4Gq6qorExKEEe93agQPKyCVhgEdAFol4St+0pWRUaiIzi1UAP6nuu6ubR5iUpDkLJ0v3it6dwFENBdV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075721; c=relaxed/simple;
	bh=NwliGA6POZUo0NrUjyXl5fIIG/7Xk3vSI0rDYbtTwr4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PTz3ZNOwkTvz3AOXbhQQ0wmwuvG+ypcthymgLfjVtlZ8flMQZ0s9MbmS3qdSJHgsq9xH/hXIrgs9GFnbWV5Ki7QhYuqNa4rcPjNoV9IWhmBBZvy0eZAJibRupFbthOl+SHZhIe8anXdeB80Lf0mbyQrnKhVejJPSPkrQlAawooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyVC97uO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A36FC4CEFB;
	Thu, 18 Dec 2025 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766075721;
	bh=NwliGA6POZUo0NrUjyXl5fIIG/7Xk3vSI0rDYbtTwr4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=kyVC97uOZEKzMdf67qIWldq8zHvQOoggsAKMh3mRCsmbVOs1IOjzfhcdapISY2SLQ
	 u2uYBgNI7yYNvMol3FW3OU52sAgU259IW5xXGk1xHMsFjLD6tRPtDyUZuBkzIF16IO
	 woNrUzAV25gkhsdSwvj8dfZvcKUc3lB+pSHF8CFbmIgk5TAsqaCKYusu1CD7UrNk8P
	 a/YEcnhWlvht4VtGc4JJnzQpHR1CLe4pwAUTFf0Ol97OMGHBkln2nXNex9fYkf9lkB
	 kH5gFtkIJnS5Pj5aqqXJ2LqOoTm/I9Dqps+mbXkB7NcE9UrPip0NBYXPW7l4Y+7E4H
	 WCLDHRZ/s8jeA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Dec 2025 17:35:13 +0100
Message-Id: <DF1HLAAHBNUF.3H9QT3WIINRR@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/10] rust: refactor ARef and AlwaysRefCounted imports
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Igor
 Korotin" <igor.korotin.linux@gmail.com>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Robin Murphy" <robin.murphy@arm.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
In-Reply-To: <20251123092438.182251-1-shankari.ak0208@gmail.com>

On Sun Nov 23, 2025 at 10:24 AM CET, Shankari Anand wrote:

Applied to driver-core-testing, thanks!

> Shankari Anand (10):
>   rust: device: Update ARef and AlwaysRefCounted imports from sync::aref
>   rust: kernel: Update ARef imports to use sync::aref

    [ Change subject prefix to from 'kernel' to 'scatterlist'. - Danilo ]

>   samples: rust: Update ARef imports to use sync::aref

    [ Add 'debugfs' to the commit subject; be consistent with the existing
      import style for now. - Danilo ]

