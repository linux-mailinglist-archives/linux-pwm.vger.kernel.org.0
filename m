Return-Path: <linux-pwm+bounces-7871-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C298CFFE35
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D7D3152CAF
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6F32A3C8;
	Wed,  7 Jan 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoB4MfJv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1B2D0C82
	for <linux-pwm@vger.kernel.org>; Wed,  7 Jan 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815318; cv=none; b=Hl5D55eA6qYBdye9b7gI6JsJ4ZEoz9hv8G2SYq+/gf8L01BKojSEM4xsfAHZXIKSeIh6dwaZWmb7eA5i/ISGH5agl4wcbFXWfImdwqsx8jjyA5coVaBaxNuVYR3t1QXdnnIAf0CTg4Q95rLNhvvhR/SMLvqSFdBQfZ9LhLkvBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815318; c=relaxed/simple;
	bh=2NF359DW37ZojkG4f4MDIy0ciudLZitBmJbZxlljHso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJaFxfHmQv2AKZtybuipwesk8Nh0GnZatnLNOskUtt4H+fhGiDruxe50sDCXUDxWdrtVG/0ZTcLzeBrI5r/kE/4f2NBjIc3BLAe3LnSjAjMAA9LMQDMSzKckgRPUyslBsTqnuODhxTFze1pgP0A7AVRnSry/H2+teN6v9HYN0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoB4MfJv; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2abf5900cd5so2067710eec.1
        for <linux-pwm@vger.kernel.org>; Wed, 07 Jan 2026 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767815307; x=1768420107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NF359DW37ZojkG4f4MDIy0ciudLZitBmJbZxlljHso=;
        b=RoB4MfJvgo8/S7am11OHkY+UURZPxzGbWLUsM2E40xaAWUCmtSbrTlcNT4C2yAgEpF
         /1wkzk+GrxJhwocREGmY/1U/rsdYh3/Vrb1SH33Y9n/urBXRWZOaZhwv/sbjrdpesey4
         43VCnzcvXLpvQXm1RSPzMm88aeeZ8OKl2MvhBBqL3JYOVotHImupPr9dXbImK+uAGKDY
         gos4rrTCx7oxm/cQm6uqRPEcW7OAnaspQK5J2XamMWI5XOz4xydqX23ZBFM70X4j3vF5
         mXe3Ju9cT0clpzRu0t/qFNJChuzfcNUCAag2hyKz8tKfSEBBA81Nj1OErkIse+0QG2Wr
         idMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767815307; x=1768420107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NF359DW37ZojkG4f4MDIy0ciudLZitBmJbZxlljHso=;
        b=KCULkiH86MeUAZOftftl8uECtfPizjUPPnPdNH+E5W6wt1Pydaa2oTA4JSTIHA/2tk
         7LeCd4EKKTvdYo+qbYPAVfsjhAkZEOgSh5Tw2hpm0Z2e+tuNQym+eLPczbTxFFRMNcae
         QS+vxPC4/aPHqkXLDxewc9o9gt1fcgyaReuOnOqNQHvsmPlfty7Ggs29Y2sJSwar0x15
         3W5wywi0xNge0xP05LBKGAKeIRiiFo3KFVr6F/cNfao2mVgeDgPBoj4vFRzNz7RsLRXh
         mjB+EHrPVFfrumdBlH0SCPF53VdKQdf81KaSsi/Mn9S0CWKtmqhuPECN2t2iq3hzu80O
         YNwg==
X-Forwarded-Encrypted: i=1; AJvYcCX+TCSG/5CexxjuIYrsL/eLBS60WtYHpO7Co4czJUpARce64bVieNrjWO41L+cX4CRMsc+RCj6Y62o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/qz5r1vdvwKoOQfyWBiQHJQW2Pw/W/cH8/vBxkxrxHyD9x5z
	By4/VEgTdZazXiLPVayGxFq7w6Cs7AnugdXAsCW4Hy15W6U+ZbDNp0X7
X-Gm-Gg: AY/fxX6wt9SQE7krr7Nb3Xl8CCuOTc9L8VW/ihA53HccuPdcj3lI93WH8yrPtisLBiH
	QP0KUOL0GSLenoD/IrvtWZRHoZXZboMSlkK+5BOUhnAhit6oNgdEpZiVXd1AeVeI57b4N9L91SY
	XFxCTNLeSZs5dKNB9YQpoNQdV1En7qV7gyBwnzikOqawOLjXjNcHNFw5R8DO/zfon9Yadx9zEQl
	8oWT4nm6Tu121Pkfjbg/KQAb1Tq2tNnNPS0qLrbXqVCR8QZCi7RRFhAhneXXY6HpD7+Nxl3y6h0
	K8FyfgLvLmALlAWRuy6Ih61yo0figWGXEIf/XHhXtpSfMeTQBD2hM46nKygT+ezWk6Z89rDeE/C
	bMlFuhLo5dUE1OtriK7BSC1zN7nN1bExHyNpH/E5n2trpdZvPuCwrPV8OAJxSZcQVcqLtNAw220
	lNdhD1KDp5J7pmCheleAKxt9eOyduw4b19hg8kMg0Ounln0TwhJVIAxVLZeuPLhlRpOdvV7nDJd
	UydXAWVFN/36pXTqD0l5ctpe0n1Dg==
X-Google-Smtp-Source: AGHT+IGYjVUu+lgv9P/uKlsGT5xYW9cLxtGl24dRMoeIVtDU/FsjhOKh8eUikrWCzN/Ql7qltByiCg==
X-Received: by 2002:a05:7300:3f05:b0:2b0:56fd:4b67 with SMTP id 5a478bee46e88-2b17d21b4dcmr1970898eec.12.1767815306652;
        Wed, 07 Jan 2026 11:48:26 -0800 (PST)
Received: from ParadiseLost.localdomain ([177.10.10.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm8626994eec.20.2026.01.07.11.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 11:48:26 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: g-praveen@ti.com,
	j-keerthy@ti.com,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	n-francis@ti.com,
	rafael.v.volkmer@gmail.com,
	u-kumar1@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting configuration
Date: Wed,  7 Jan 2026 16:47:58 -0300
Message-ID: <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Uwe, Gokul,=0D
=0D
Thanks for CC'ing me on this thread.=0D
=0D
On 07/01/26 15:21, Uwe Kleine-K=C3=B6nig wrote:=0D
> Hello,=0D
> =0D
> adding Rafael to Cc: who sent a patch series for this driver that I=0D
> didn't come around to review yet. Given that neither he nor me noticed=0D
> the problem addressed in this patch I wonder if it applies to all=0D
> hardware variants.=0D
>=0D
=0D
I also didn't observe the issue described here in my testing: duty cycle an=
d=0D
period changes always appeared to take effect as expected.=0D
=0D
My tests were done on an AM623 EVM.=0D
=0D
One possible explanation is that my test flow mostly exercised configuratio=
n=0D
while the PWM was already enabled/active, which could mask the effect of a=
=0D
put_sync/reset happening after configuration.=0D
=0D
Regarding my pending patch series for this driver: it should not =0D
conflict this change, as it's largely preparatory refactoring for a =0D
follow-up series.=0D
=0D
Best regards,=0D
Rafael V. Volkmer=0D

