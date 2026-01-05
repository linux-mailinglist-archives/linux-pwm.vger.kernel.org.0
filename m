Return-Path: <linux-pwm+bounces-7847-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F673CF47AF
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4964E307D453
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF7F33DEE3;
	Mon,  5 Jan 2026 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUBiqiVx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54233BBD3
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627675; cv=none; b=DGBDUCWIRFIqriDQY8/Vyq2RRVK4Z0tkt0iM3nU5O6cqdyHBuxnxjFquX38K2BlQW6Smmi3mNAigiJeyW0OrbMosgdp3qzjxrOPkGrAZIPT5W5IemwtLNzOtGAnDkO5Q6SKpc05Loq26QWN1USz3pHo4GY2ylQJZqCwxtjB68HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627675; c=relaxed/simple;
	bh=7XOckaOqG/PMRqT76fU8qmeyL4hEz8+C+ksukJDZjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGWGPUD2CrOy2ltnG3WXiXaS+Wmh/F9WokNBeF633DIgfXlPrV69eN5VFmQdo8en4KhyklF40fOnEAqIFEho+z+dK1sgOPlHPYWev51n6NbNbPS448ebBqPVma6EUFmp3zjBW9XDYjke97Z4RrA4mTxDvDsHDpR0ZuzrVHh1OVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUBiqiVx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a2f2e5445so183057306d6.1
        for <linux-pwm@vger.kernel.org>; Mon, 05 Jan 2026 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767627672; x=1768232472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6BA1g1a3pdykyjLkvUREMTVpM7/WCPoUOv36P4M2nY=;
        b=RUBiqiVx/t7vGe/RuVzxTndk5myDZoEYkfhTue9om2uBkHmkh6wNYFMeygSKfoG57i
         g4rocB+BZkVWJDBF7aG5eK98iD/gtEoPszHnHmGmpL+7ZCWkvaMX9L5UKFDteiHD8EeS
         l7UHrIFRjibO8zrknZ7cgchU9IdVmyS2x9PsbihAp3V7VnZzIdR27daG66XcrUu+p/hc
         kmb0YHtx/4U2mjfU8CLYz1IKFKPfHw3hMBTu/8Fp/fRZeSmFdwkh/nhiCu6gxmqohHT+
         WFO/Gce068TXQuHwMpO/73nAGE7zUo8xE9+WRcSk/fWGkW7IHuvTxVEXWmk4HcteKsL4
         GMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767627672; x=1768232472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6BA1g1a3pdykyjLkvUREMTVpM7/WCPoUOv36P4M2nY=;
        b=nShFsW0Q0Lyoz46C7DX4xZ6Ev2OHsdxSBTlL4EezF+jGbDuWdv357S/AOH7mO9Nlu4
         K+3doq/fZXeLOcuwUqmfYEVUs4T2yvLwcIt9OVxCXPeRtz/RNWtdt1Xyd23vhMAtIVnF
         gwblL4clYl8Yw3Zv1s7h3FpVcuNonoaTWWne11CcXfxfi9YrmGSZaUkV4yLVuD9k4fUa
         1djZyNxDONCtbi/CO/GmdTCLONSivi226ibESYvfA9aZNBQxun9U90NUgVbHIJHrqkCL
         TX4Sjh4iKmz9Ymg/3jD1YxosGSZYOev3hiucYhTVsxmTr7UcXdRvn8wTE7PQ7wQ4yjHp
         C8QA==
X-Forwarded-Encrypted: i=1; AJvYcCXVP5/5Zwj2oD+uD+g7TkjQgbXAwig0afE1G7RmbBNnde4M4DXQq2XdDlGgMet6zeDV+zs8yw75yTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSiV+XuiqpDy1ytxXw5eeff8Z363DOAL0wiRUBKlkgNuN2KPfV
	dzp/jsE5DgfPTpWsxPPNIJ8m06cbWXlwYDo8eN40Y3bFevSIQbkUjkyF
X-Gm-Gg: AY/fxX6+GntdNaDwsNUjkiqKvB5PpznEs9uts52rHH3UT4HTQBPvmomMq51Yl3AL7MJ
	VbWHrEcQ478gkbj9qPi7uTz2P65T8PQc57+gWzUewv/VEfSAM+U5Suy6Mnv/segjzMNGe94ndm7
	TQEYXjiv+5UXzBBMNjNWXkY+f+G44whH6hiAyv5pnd68nMJA5mPLoVDJmBd4ktobOeaZdX4bJt4
	mP6RUF+MjjCSuiTV5IJ7yfJLoPDbKNLO7C6mObtKA4E6MONmjIv589kBj89tJ4DZmSYwUUoJkCf
	+VuEFrNceJNHuExT4/ZRCNf8AgYvHQ1bqIV/zZ3t2GKRkCKCbpGCHRGLtkJNm2eUoNBAghOZC3F
	XyR1E/QTbdogReLyJHHGrDpPbLRyp2QzKOmcWZqwy8muKgzc0aauSM4hxSDNOm0aMOjl9HE+zTl
	LbpK9GjZd+++w4gYTWH9BIZIpDF+5ReXuT/uTczF7pI+7i/o/S5P837DL/fg5tfvytLAgZ8dP//
	i0RSF6zfp6myjM=
X-Google-Smtp-Source: AGHT+IHeeyt4Xeum2e3H4UlfOCeEPZyOgjULTv/XI4YZg24EjWSSkO3V7ao10G0yIxqhA1gkrd4grw==
X-Received: by 2002:ad4:5250:0:b0:88a:4ab2:5f52 with SMTP id 6a1803df08f44-88d83d65360mr521106156d6.51.1767627672608;
        Mon, 05 Jan 2026 07:41:12 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89075557d23sm1207046d6.41.2026.01.05.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:41:12 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F0F5F40068;
	Mon,  5 Jan 2026 10:41:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 05 Jan 2026 10:41:11 -0500
X-ME-Sender: <xms:l9tbaQl8adq_q8oemVdp9py9aCB5rEYMUXGPUHOfxSENDh0M6SOSiw>
    <xme:l9tbaVrCyG7LEDf5sozj9kkhyLQ0sPqK87jUAC_qJfbekq6ICe_xe5QMuMoTjEKUA
    tB0zjAhiqSBWufmhb_KP365bDbxKmKQ-BUeRDG7AXs90zPIyqpX-w>
X-ME-Received: <xmr:l9tbaTuvJMNXCwyVLLEQxwAkDuZHya194bV4WrOdHwOVBYRN60UCxK-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeehkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepphgvthgvrhiisehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtohepvghllhgvseifvggrthhhvghrvgguqdhsth
    gvvghlrdguvghvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:l9tbabmkDu5goAML_Vw6wQks5sr1-oqWVGEVyl7SpncPG41qLq8PqQ>
    <xmx:l9tbaZEvXpCwph3gfl5iq-kHa4fsrJ-e6g21CjltgBbR441YOY405w>
    <xmx:l9tbaa8pxEfCJ2_idKerH3733Rocx35rGJlDBn4X7HlKs2MkaFUX5A>
    <xmx:l9tbaW7nR-qjUaIEByc4-kPNbC8tpKXp-OM_EvS1h_evQ7bx_68mJA>
    <xmx:l9tbaS4UkZJm3L0Tu3phQb3ItLU_OD6WXZGJ8xIIxpleNVBlr6HjnmTP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 10:41:10 -0500 (EST)
Date: Mon, 5 Jan 2026 23:41:08 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gary Guo <gary@garyguo.net>, Peter Zijlstra <peterz@infradead.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Andreas Hindborg <a.hindborg@kernel.org>,	linux-block@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Benno Lossin <lossin@kernel.org>,	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,	Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>,	linux-security-module@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ard Biesheuvel <ardb@kernel.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,	Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,	linux-pwm@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,	rcu@vger.kernel.org,
 Will Deacon <will@kernel.org>,	Fiona Behrens <me@kloenk.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,	Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using
 LTO
Message-ID: <aVvblLp8sjFB7JvB@tardis-2.local>
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>

On Mon, Jan 05, 2026 at 12:42:13PM +0000, Alice Ryhl wrote:
> This patch series adds __rust_helper to every single rust helper. The
> patches do not depend on each other, so maintainers please go ahead and
> pick up any patches relevant to your subsystem! Or provide your Acked-by
> so that Miguel can pick them up.
> 

I queued the following into rust-sync:

       rust: barrier: add __rust_helper to helpers
       rust: blk: add __rust_helper to helpers
       rust: completion: add __rust_helper to helpers
       rust: cpu: add __rust_helper to helpers
       rust: processor: add __rust_helper to helpers
       rust: rcu: add __rust_helper to helpers
       rust: refcount: add __rust_helper to helpers
       rust: sync: add __rust_helper to helpers
       rust: task: add __rust_helper to helpers
       rust: time: add __rust_helper to helpers
       rust: wait: add __rust_helper to helpers

Thanks!

Regards,
Boqun

> These changes were generated by adding __rust_helper and running
> ClangFormat. Unrelated formatting changes were removed manually.
> 
[...]

