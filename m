Return-Path: <linux-pwm+bounces-7815-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FCCCCDBA
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 17:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0820305E1E7
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CF3587AB;
	Thu, 18 Dec 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmtKthG4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEF357735;
	Thu, 18 Dec 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075876; cv=none; b=HG5ukJUwo9MfLVHMDM/GKRtFIGw0Ea/DSRUlApAxxpikWTK5nPb3Tzmba9j2vFGWonHFSpVCDkxFiJpD76R0qBezW+YcNoVhTcWwO+MeWdnbDoeJ15MBg5irMDQqSnCkiIqOn9oVpm25d909tjcZval1z8mMPjIyYPq6xTyX5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075876; c=relaxed/simple;
	bh=ixJO0hu3i8cJobG3c4G/ECbCHJ9nWmL7QeH2/4xi6PA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=aYMhsalz56WBR0i6LP5sZJBWQ6uHPiUEi8UbJst9E75jA7UxZIXJ7x+uLUXuNND1C4PbIVg81XA8zXzGMtWb2wQ4lPWthGX9BFuuf5XULe1Fp43Ey34Bc25fz2DzdRriDJ8dJPCxqgDSjXs7lJdf77DYSO6AieoEJkX9r++xRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmtKthG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31901C116C6;
	Thu, 18 Dec 2025 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766075875;
	bh=ixJO0hu3i8cJobG3c4G/ECbCHJ9nWmL7QeH2/4xi6PA=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=rmtKthG4N75e7AtksrHk8MSlRGJ5S3zbRUQIQKN3ChxSzzwZmbTM5vghy6k/uqhT8
	 7u/QOGX3h6jlBm7TTNis2wHRwnoQfOHhbvQ/AlfDdkuRXr8gEwuEjN4DVex09gDzCb
	 pBYbnIP1nePsyj1v9XJOM+vHPwr5jjx6a9Ti2pEpPXDj5U8thW9sCbQKn34Pn4coQN
	 oSBwEldbgTPWal2DuI6OII4H1P9CKnbECHAiUgRvS3YXb5iD5ygNQIaDwFF289J4sV
	 s8/cwe1HNHvx0VydgWR2fhSMbHI8zyghZDq/xVEzQLup5rlwVAptrNbfVOI6dayFhy
	 l8LPGvL4BcIEg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Dec 2025 17:37:47 +0100
Message-Id: <DF1HN90AG0R2.3TQDS8IQ6ZP0R@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 05/10] rust: kernel: Update ARef and AlwaysRefCounted
 imports to use sync::aref
Cc: "Igor Korotin" <igor.korotin.linux@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Martijn Coenen"
 <maco@android.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Christian
 Brauner" <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Michal
 Wilczynski" <m.wilczynski@samsung.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Robin Murphy" <robin.murphy@arm.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>
References: <1b7408c5-64a8-42f1-92ab-dd90a883c1a4@gmail.com>
 <20251205184023.7230-1-shankari.ak0208@gmail.com>
In-Reply-To: <20251205184023.7230-1-shankari.ak0208@gmail.com>

On Fri Dec 5, 2025 at 7:40 PM CET, Shankari Anand wrote:
> As this patch is part of a series, am I supposed to send all the patches =
with a v2,=20
> some have been acked by already, hence I had the question?

I suggest to resend the series without the patches that have been picked up=
 in
the meantime.

Also, I suggest to change the prefix in the patch subjects according to the
subsystem they target. For instance, you patch updating the USB stuff is na=
med
"rust: kernel: Update AlwaysRefCounted imports to use sync::aref", which ma=
y be
overlooked by maintainers.

