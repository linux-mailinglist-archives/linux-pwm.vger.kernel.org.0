Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C1BB796
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfIWPMH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 11:12:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33897 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726413AbfIWPMH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 11:12:07 -0400
X-UUID: 0803255001274d039f165dabacd3c12d-20190923
X-UUID: 0803255001274d039f165dabacd3c12d-20190923
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 397497340; Mon, 23 Sep 2019 23:11:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Sep 2019 23:11:54 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Sep 2019 23:11:52 +0800
Message-ID: <1569251515.4102.31.camel@mtksdccf07>
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
From:   Sam Shih <sam.shih@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <linux-pwm@vger.kernel.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Mon, 23 Sep 2019 23:11:55 +0800
In-Reply-To: <20190923133626.GA4671@ulmo>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
         <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
         <20190921002149.GB86019@mithrandir> <1569208857.4102.9.camel@mtksdccf07>
         <20190923133626.GA4671@ulmo>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 2019-09-23 at 15:36 +0200, Thierry Reding wrote:
> On Mon, Sep 23, 2019 at 11:20:57AM +0800, Sam Shih wrote:
> > On Sat, 2019-09-21 at 02:21 +0200, Thierry Reding wrote:
> > > On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> > > > From: Ryder Lee <ryder.lee@mediatek.com>
> > > > 
> > > > This adds a property "num-pwms" in example so that we could
> > > > specify the number of PWM channels via device tree.
> > > > 
> > > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > Changes since v6:
> > > > Follow reviewers's comments:
> > > > - The subject should indicate this is for Mediatek
> > > > 
> > > > Changes since v5:
> > > > - Add an Acked-by tag
> > > > - This file is original v4 patch 5/10
> > > > (https://patchwork.kernel.org/patch/11102577/)
> > > > 
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > You failed to address Rob's questions repeatedly and I agree with him
> > > that you can just as easily derive the number of PWMs from the specific
> > > compatible string. I won't be applying this and none of the patches that
> > > depend on it.
> > > 
> > 
> > Hi, 
> > 
> > Thanks for getting back to me.
> > 
> > New pwm driver (patch 04/11 : "pwm: mediatek: allocate the clks array
> > dynamically") can support different variants with different number of
> > PWMs by the new property <num-pwms>
> > 
> > For example:
> > 1. Use "num-pwms" = <2> and assign clocks pwm1, pwm2 for mt7622
> > 2. Use "num-pwms" = <6> and assign clocks pwm1, pwm2, pwm3, pwm4, pwm5,
> > pwm6 for mt7622.
> > 
> > If we just as easily derive the number of PWMs from the specific
> > compatible string in this document:
> > 
> >    - "pwm1-6": the six per PWM clocks for mt7622
> >    
> > This looks like all "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6" is
> > required property in DT, It doesn't make sense.
> 
> I don't understand. Why doesn't that make sense? If your hardware block
> has 6 PWMs and each can be driven by its own clock, then you need to
> provide references for each of those clocks, otherwise you won't be able
> to use them.

Thank you for your instruction,
I will add all clock-names and clocks according to
hardware blocks instead of value of <num-pwms> in DT.

> >    
> > So we removed those descriptions and added  
> > 
> >    - "pwm1-N": the PWM clocks for each channel 
> >    
> >    
> > But the max number of clocks from the compatible string are still
> > important information that should be provide in this document.
> > 
> > 
> > What do you think of this?
> > 
> >    - "pwm1-N": per PWM clocks for mt2712, the max number of PWM channels
> > is 8
> > 
> >    - "pwm1-N": per PWM clocks for mt7622, the max number of PWM channels
> > is 6
> > 
> >    - "pwm1-N": per PWM clocks for mt7623, the max number of PWM channels
> > is 5
> 
> That's what's in the bindings already, isn't it?
> 
> 	 - clocks: phandle and clock specifier of the PWM reference clock.
> 	 - clock-names: must contain the following, except for MT7628 which
> 			has no clocks
> 	   - "top": the top clock generator
> 	   - "main": clock used by the PWM core
> 	   - "pwm1-8": the eight per PWM clocks for mt2712
> 	   - "pwm1-6": the six per PWM clocks for mt7622
> 	   - "pwm1-5": the five per PWM clocks for mt7623

Yes, You are right, 
I will keep original description and remove "pwm1-N" from this patch.
	   - "top": the top clock generator
	   - "main": clock used by the PWM core
	   - "pwm1-8": the eight per PWM clocks for mt2712
	   - "pwm1-6": the six per PWM clocks for mt7622
	   - "pwm1-5": the five per PWM clocks for mt7623       

Actually, MT7629 also use "mediatek,mt7622-pwm" as compatible string,
but it's hardware only support one pwm, so I was wrongly stick by
expecting "pwm1-N" in clock-names based on "num-pwms" in DT.
(that we can assign num-pwms to 1 and only provide pwm1 as clock-names)

Maybe added mt7629 description to this document can solve this simply.
	   - "pwm1": the PWM1 clock for mt7629    

> Note that the description of the "clocks" property isn't quite accurate.
> It should be something like:
> 
> 	- clocks: One phandle and clock specifier for each entry in the
> 	          "clock-names" property.
> 
> In the above you clearly describe which PWMs you have to specify for
> each generation of the hardware block.

Thanks for your advise, I will update this description
	- clocks: One phandle and clock specifier for each entry in the
	          "clock-names" property.

> > 
> >    where N starting from 1 to the maximum number of PWM channels
> >    - num-pwms: the number of PWM channels.
> 
> That's redundant information. The specific number of PWMs in already
> implied by the compatible string, so you don't need to duplicate that
> information here.

Okay, I will remove it.



Thanks,
Best Regards,
Sam 


