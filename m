Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6643E1ED3
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbfJWPFV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Oct 2019 11:05:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42705 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390431AbfJWPFU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 11:05:20 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNICN-0001DX-M0; Wed, 23 Oct 2019 17:05:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNICM-0003oD-0j; Wed, 23 Oct 2019 17:05:18 +0200
Date:   Wed, 23 Oct 2019 17:05:17 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191023150517.u4hmnd6m4qyshu6q@pengutronix.de>
References: <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
 <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
 <20191017151437.GA85210@ulmo>
 <CAHCN7xJduG9yxAhuW6D1_kpd5=p7LhO_YCWjVxcCoW5bmSEJGQ@mail.gmail.com>
 <20191017171326.GA531411@ulmo>
 <CAHCN7xJWco5gTdjmJZRbNqi1aO+ytor5XMJWQX8a38tfGbz+xg@mail.gmail.com>
 <f6d2427d-21fe-e89c-0bfe-572bc1d00863@ysoft.com>
 <CAHCN7xJJH12sdeLb97OutJqThv+TzMaNj-Y50_C9G7UgEQCbxg@mail.gmail.com>
 <CAOMZO5AgUjA8eSNVM_rKi-7NAX8hj039STcJ4Ov4w-0m4WTf8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AgUjA8eSNVM_rKi-7NAX8hj039STcJ4Ov4w-0m4WTf8w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 23, 2019 at 11:23:11AM -0300, Fabio Estevam wrote:
> On Wed, Oct 23, 2019 at 11:16 AM Adam Ford <aford173@gmail.com> wrote:
> 
> > What is the plan to address the regression for 5.4?  I wasn't sure if
> > we're going to apply the i.mx fixes or temporarily revert the
> > offending patch, or something else. (or maybe nothing at all)
> 
> Yes, I do see the regression on a imx53 board with 5.4-rc too and also
> interested on a fix.

Thierry already sent a revert of my change to the list. We only
discussed the wording shortly and I expect that this revert will make it
into 5.4.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
