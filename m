Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C16392EB8
	for <lists+linux-pwm@lfdr.de>; Thu, 27 May 2021 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhE0NBy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 May 2021 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbhE0NBv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 May 2021 09:01:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EAEC061574
        for <linux-pwm@vger.kernel.org>; Thu, 27 May 2021 06:00:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g7so752188edm.4
        for <linux-pwm@vger.kernel.org>; Thu, 27 May 2021 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=/qN8xEQi3ma7OczhXRoGk29ArwNwt4NsItcOxhRz/50=;
        b=hGXKUN0rnT4AXodO5hn5rqoZnk/794xnaS1eUBWWaiAS7u4ss/khwiysrO2Oc8IgWV
         CnNb6LW9nkSpEizNsc3GWkKiHk6Yj9eAQVOEsZez0A1+ezIl+9rLZLu2Vj8KXFBOAYcU
         BG/+hcyrlpA8jinY56eV9Prl1mo6ChaHYVNkVacgVznNHTHfVEBp4rtZHTgm6RT5ocNi
         2CpZObCmUOjwrDddoyAg0ZC9ttdECVUBCKbQOlYdX6MHEBeX/GzTeir40yPmCa98SPbp
         e5iwgn6itb7+YeTkCwMLSl109Gh0Hvpocj3/TclpGSR/zjdpEVfNY2eboMDesRIpjhV6
         VIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=/qN8xEQi3ma7OczhXRoGk29ArwNwt4NsItcOxhRz/50=;
        b=auH+QAWWUreWbyD5JZfyZDUCZmCHHgtXszCvhrQ6evqdBWloPqarxPLadPDXu/axxF
         f4pyEPutCNgalhE+I9FL/2UHBpXCEhIq/Ad+aa88JLvRI3KrvMKkLuZrHwzz73aMX59D
         djPE/nv9FRNGrB5P+UJ4eK8uP5dtJ6Vuda8VKKS1MXmIysD5sn36jsrRvz/j6cSdmvGT
         r6ZPLsDv9HemTWgvO3ckWLqk60PuDvfCV47bKnuSeH+r1LFKNcOFBhTFJSb3pdO+cZlc
         R/sWd2ReMtBHIsOsxnjRhL2mz9pStprl6VYebhBd1jjsCjtreYnyZcDvhVxIHMq7Lon9
         29wQ==
X-Gm-Message-State: AOAM532eKMHaPGM/TXSZ3887I8/7mGGjpLXghuYshIMfMny78J5+N4Ov
        jOhazowGYsCnfWS5BySIxBaCRQ==
X-Google-Smtp-Source: ABdhPJyRfCR44IU2GP/xaHqMSY57isa6F9MiLF0YdDGQfjxjc6ZBx8XIz3e0llUitpYy/WJXxL8wCw==
X-Received: by 2002:a50:fb17:: with SMTP id d23mr3960725edq.338.1622120406960;
        Thu, 27 May 2021 06:00:06 -0700 (PDT)
Received: from localhost (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id b15sm1051503ede.66.2021.05.27.06.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:00:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-sunxi@googlegroups.com>,
        "Roman Beranek" <roman.beranek@prusa3d.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
From:   "Roman Beranek" <roman.beranek@prusa3d.cz>
To:     "Thierry Reding" <thierry.reding@gmail.com>,
        "Emil Lenngren" <emil.lenngren@gmail.com>
Date:   Thu, 27 May 2021 14:10:35 +0200
Message-Id: <CBO0N2KNI5MJ.1KDTI8B2UE4SM@zen.local>
In-Reply-To: <YK0onNy2r30aNw2g@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Tue May 25, 2021 at 6:41 PM CEST, Thierry Reding wrote:
> I'm pretty sure Alexandre at the time reported that the instantiation of
> the controller that he was using required waiting for the period to
> complete before the output went to the disabled state. It's possible
> that this was changed in subsequent versions of the IP, so perhaps we
> need to distinguish based on compatible string?

I've got myself an A10 (sun4i) board to test my new patchset with and
indeed the 2 cycles seem to be enough.

I have yet to write a cover letter for it though, expect it by Monday
at the latest.

Best regards,
Roman
