Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F311FF84
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 09:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLPISv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 03:18:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43177 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLPISv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 03:18:51 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iglaW-0007fX-In; Mon, 16 Dec 2019 09:18:44 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iglaV-0003S5-5C; Mon, 16 Dec 2019 09:18:43 +0100
Date:   Mon, 16 Dec 2019 09:18:43 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, sj.huang@mediatek.com
Subject: Re: [PATCH v2 1/2] pwm: fine tune pwm-mtk-disp clock control flow
Message-ID: <20191216081843.yxe3vm674jwurwri@pengutronix.de>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
 <20191216070123.114719-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216070123.114719-2-jitao.shi@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Dec 16, 2019 at 03:01:22PM +0800, Jitao Shi wrote:
> Match pwm clock when suspend and resume.
> Prepare and enable disp_pwm clock when disp_pwm enable.
> Disable and unprepare disp_pwm clock when disp_pwm disable.

Assuming you catched all clock operations (I didn't check), the patch
looks fine. The commit log could however be improved. Additional to
describing what the patch does, some words about the motivation would be
good. Does this fix a bug? Is it to save some power while the PWM isn't
in use?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
