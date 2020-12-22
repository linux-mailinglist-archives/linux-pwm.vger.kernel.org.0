Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B762E0D6E
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgLVQfJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 22 Dec 2020 11:35:09 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:34480 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgLVQfI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 11:35:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 8A081A38DF;
        Tue, 22 Dec 2020 16:34:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo05-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo05-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M2GvWqAe3Y19; Tue, 22 Dec 2020 16:34:27 +0000 (UTC)
Received: from jupiter (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 46D24A0B1E;
        Tue, 22 Dec 2020 16:34:09 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-rockchip@lists.infradead.org, thierry.reding@gmail.com,
        tpiepho@gmail.com, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] pwm: rockchip: Eliminate potential race
 condition when probing
References: <cover.1608407584.git.simon@simonsouth.net>
        <20201221091618.oxjpmlnmo5iaobt7@pengutronix.de>
Date:   Tue, 22 Dec 2020 11:34:03 -0500
In-Reply-To: <20201221091618.oxjpmlnmo5iaobt7@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 21 Dec 2020 10:16:18
 +0100")
Message-ID: <87wnx9ol50.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> While looking through your I found another little problem that you might
> want to address: rockchip_pwm_get_state() calls clk_get_rate(pc->clk).
> According to the documentation (in include/linux/clk.h) this is only
> valid for enabled clocks but there are no precautions that pc->clk is
> enabled.

Sure.

Thanks very much for reviewing all this, Uwe. I'll follow up shortly
with a new patch series.

-- 
Simon South
simon@simonsouth.net
