Return-Path: <linux-pwm+bounces-9633-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tVbjCtUnTmr5EAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9633-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 12:35:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E4572460C
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 12:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E0d04Hnb;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9633-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9633-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B6BC300F241
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCE03F4DE7;
	Wed,  8 Jul 2026 10:34:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288F3FFF81
	for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2026 10:34:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506874; cv=pass; b=gI1YxmTMmfVbLdL/+yMpoNUXIuDkbAAhaGOOzDZDj0H0sGPwPhk4Wx+lDsU4RgcJ4gAuBFFWbwmXAHA4XWQ6cTMggBHgQOt+sB8IB5i8+BLEhw8ifUW7YqeBgldFUmLH+e83vleVxWli7MuzlkRpQyU759prFSfRV1eTUz1iGyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506874; c=relaxed/simple;
	bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdFIQpIyLoC/7KPSuLFGvyYKKQlQ8N533yOucIYIky/9JFyC3T470+yjx1zUw1sJit0PeqwLfQyjpO4/oAvdSakICfc7k5bczH3ksF2PzV12k92pq7DnQLahJe1iAM7kYaWFWs99Ba35z7NHCkKWfceidm62AUimyXRUVdWqzmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0d04Hnb; arc=pass smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca6a6181273so13714a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2026 03:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506860; cv=none;
        d=google.com; s=arc-20260327;
        b=X/gaXK8sdUDSYYEUjDKIQhviA26nmu1z6O68dLuSS09zjfJeswVVSSJ9+/0KJjN4KQ
         P5oU7iMCE7ylXhfj27/irkb/zqKevJ582ywGRlbk4Clh1CS0+vLT2Lx2XtfiZ7vRKs3N
         cEzsEF6PBt+xIVKWom8FJJepit1UQj1VqBUSv8StlrSlKKFxTcH0DgTaqE+G6/kGQJt/
         4fQBYS0TaYbQUaVaG8xk2F3qHZytt6FD5cQuqJxbEcojU97W1ysvPm7PgUDncYQazJER
         wYcTbPn+tY7A5qREL9Ra0FmTPDQctgOwvuyWdLxgxxdOz56TnUhQyEkWQP/t9nkOgzhT
         KCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
        fh=GoIkv1zV+Z1IkweXsTBZywfpaWfpyB6otbfb8mzZgmQ=;
        b=hu/HSpy8fln3rS7SD4eBthOrvWEjvEcLk3Y7IHcxGWUe2+PkTKigTxrgXbaay2i3dI
         V0lxO8RduPj2sdcw5GUS5cQjwQu8oukdDErhHzcEUhDe8qnPElWe7LGgF9dp0dx2HoiQ
         /QQGn0YQjaEZfJSViVtOgnOBzgDxBzOeocmEMgV1tk9Xk/KJSWK/aziiPvz1aqkvx9ZE
         L7+kqGt85WeZgdUHi5PCKlcUDc19NNyLNLUjIVDuuf+bL2I4cuFWH1rbMlWv29NI0chU
         jd0opK6ynQm0uKZf1UZpwb4U+rYQFwqNLkIFnSPHAiXvHR8Zm1+QW6bQ/VaZfv+M/aeQ
         1F6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506860; x=1784111660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
        b=E0d04Hnbd5JBCfkVVLlFLQCBGKGoe9pZsPHSWTt6VNJ0g5LRhsDq7W/Ymwg5sW67NW
         KI11RQLjO/5CmLcT3DjVJ9C/z0A01YaKz0aXxXLwdu6FZduvJhUFKp1zv6BLk8EpEAcK
         sf3EJDfHXBH8Ma84DRK1xo0HwzqHpxPPsjgPhwB9tPqSJoUheBnGo5Ii1WaLevaR2Jph
         TfpQcSiJxiT38J10Lh9fRhVi/p1E5adua3i7FHEoukRnkBXz0QMQaVxTJunKMfzKyOed
         1DG5v+x8HNSRTPqAQeGq/TnDGc/higgta9bj3ENqwpuJmfiA7b7gX4+geZ633yUuQc5m
         buFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506860; x=1784111660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
        b=qxk7RRg9KvMb6Nj8Xei7Ht6yYaWxByf1eInPR6v/RyF5/ISMcFeqNQjpMlxMc5HqPv
         CwXMdEHY3lecXR6kMsHc/x+9IYRwJ8l/xyrGUq8fFZ4hE/pGQVlvNfhONFwgAS9D6h13
         Q4kuWA5vwtllJgVt/MqU+MeL6eMhEEjYW6bj4bHfojvJFhZ3jCGMn4R+DlHNhPZkVmqW
         QVMGDxAhNoagHP0b3t1nS3Sv8QEes8ZBZMUyTMUjrGFFXNao+0vr4nt1PRb2x3nmJC7X
         8Zd3505/LDFK8eqfh5JjVPCry5rooOPjzNuj0pQvsNmjRxtoidE25vapvy1287GXKcKC
         WCew==
X-Forwarded-Encrypted: i=1; AHgh+RoOXXCM8P/pPKf5Vqd4gjy8h8i6D9WWju9inN2gybgQbduZVaiQLxNmUvcUBBfMUyHv8cH4k9JAha8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQdekNtwuRt6n0+lrlRqshencni6zyvqKLT1/jjCKvc7NKiZl
	DlKXsQqo7KTMl8K+dTu0cW0FtVsfYJtOTzau4Fd6GM0GUqAX4vAnS7RwxRVzZiML6oJIZkkQElE
	9KjifvxHWDU3B8p7E8X4Bobznb68dhOc=
X-Gm-Gg: AfdE7cnUF/e4qGMbHPs793vrd2J2GePKWA5frfmhuQpkixDakbwGAW8zZXjNhvMYH3R
	7X6+4IC8T5ctO9dWd364vGoVx8YWsCAbZBxyl67+I7VYfqD7KGZmsoRIOY0tIbxcuQoqx/OW11K
	XuI9pJDx8zOkSRwriT/oSDRt1JdvXVW00zfAe6ygD4Mq9b3lu9335k9HKObOx21DN/lFuKPq1R0
	RKzGZ5ABFuNF9ugWSSFgJo4KYt2JfQ3XU/DETMrOHSFK3ur8h6ljzTFXLdyXclXX3+mJWRdHy3X
	2mGE2TK+eqx9iivDpfrh7cO7cmu+bq899LCJR+BezFTtIqjEsNiP8q664RpOP9V2s2yxbYrM/3O
	Y9uQqFa6u7/8N
X-Received: by 2002:a17:90b:57cd:b0:381:2d9a:447b with SMTP id
 98e67ed59e1d1-389417e436cmr1662657a91.4.1783506859636; Wed, 08 Jul 2026
 03:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net> <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
 <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
In-Reply-To: <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 12:34:06 +0200
X-Gm-Features: AVVi8CerPf3D12GiMfvLd9xxakdPl4vxt6Mk91TDYQmPEW-zWuPFQaL-PCqilw4
Message-ID: <CANiq72=8V967CuH92AJBAob6YaygXtCYY1GAr=qGuF8JzQfZ3A@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:daniel.almeida@collabora.com,m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9633-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24E4572460C

On Tue, Jul 7, 2026 at 10:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> It does, but if the alignment is 8 then it breaks a lot of platform devic=
es. 4
> is the most common alignment needed so it is chosen. Different base types=
 can be
> added subsequently when needs arise.

Maybe a two-line comment/doc would be worth it?

Cheers,
Miguel

