Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7011F83A6
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2020 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFMOPr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 13 Jun 2020 10:15:47 -0400
Received: from a27-23.smtp-out.us-west-2.amazonses.com ([54.240.27.23]:60462
        "EHLO a27-23.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbgFMOPr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 13 Jun 2020 10:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1592057745;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=S3ZCFDWXKOT7/mmjCpPJc5VmTrE8+V5Macg9hSjNpkg=;
        b=S1BTsyIGrnuJpcdsrSSc3IjExrja2YMTBrORN/JQlSyZivgSYrjTg+6DVyq5oXwB
        WXbSzRGeYDVwGErsaHHt5Le7oyfES5t61SN+6lox+AJQF0seYVU5ujZTZgcK6vCbNB0
        sp1BejNkY6hQhvaD/cc1cnXn4mD/vX/+bd609OqQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1592057745;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=S3ZCFDWXKOT7/mmjCpPJc5VmTrE8+V5Macg9hSjNpkg=;
        b=ZFuIT3V0FSXBWWunqLM7kRwaFu5FShrBEYKHW+heX9NR5vMFdwm9b7d9/t4tdXTN
        AJ775gJgOxNeh/5PW8iA20US8akoA/964kEXpUBR21reYfx/7QM+eXT0nT3ksG69ZOC
        F0hKAQBT69Rcho+rTjgshU9bX3HEl6N5VMxDxlSE=
Subject: [Kernel.org Helpdesk #89942] [linuxfoundation.org #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
Message-ID: <01010172ae094ffd-ea4dd80a-69fa-482a-9a9b-bce6fcb2d612-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
X-RT-Original-Encoding: utf-8
Content-Type: multipart/mixed; boundary="----------=_1592057745-21854-8"
Date:   Sat, 13 Jun 2020 14:15:45 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.06.13-54.240.27.23
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1592057745-21854-8
Content-Type: text/plain; charset="utf-8"

Hello,

On Sat, May 23, 2020 at 07:05:58PM +0200, Uwe Kleine-König wrote:
> On Thu, Feb 13, 2020 at 11:26:18AM +0100, Uwe Kleine-König wrote:
> > I consider the archives on lore.kernel.org very useful and would like to
> > see the linux-pwm list archived there, too.
> > 
> > Assuming you agree (or at least don't disagree) we'd need to follow
> > https://korg.wiki.kernel.org/userdoc/lore. Therefor we need an archive
> > of the already sent mails. My personal archive only goes back to Oct
> > 2018, so I guess I'm not in the best position to provide it. But I can
> > nevertheless care for the buerocratics and start with my archive given
> > that I get some support from someone with a more complete archive.
> > 
> > What do you think?
> 
> I didn't get feedback from Thierry (= linux-pwm maintainer) but I still
> think adding linux-pwm to kernel.org's public-inbox instance is
> valuable. (And if it's only to experiment with b4.)

In the meantime Thierry said to support the idea to get the linux-pwm
list archived on lore.kernel.org and also provide his archive for the
initial population.

I assume you're OK in principle to archive linux-pwm and it's "just" a
matter of lacking time to work on getting this list up and running on
lore.k.o? Is there anything we can do to simplify the things for you?

Best reagards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |


------------=_1592057745-21854-8
Content-Type: application/x-rt-original-message
Content-Disposition: inline
Content-Transfer-Encoding: base64
RT-Attachment: 89942/1975529/1655478

RnJvbSBTUlMwPVZlOG89NzI9cGVuZ3V0cm9uaXguZGU9dWtsQGtlcm5lbC5v
cmcgIFNhdCBKdW4gMTMgMTQ6MTU6MzkgMjAyMApSZXR1cm4tUGF0aDogPFNS
UzA9VmU4bz03Mj1wZW5ndXRyb25peC5kZT11a2xAa2VybmVsLm9yZz4KWC1P
cmlnaW5hbC1Ubzoga2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlv
bi5vcmcKRGVsaXZlcmVkLVRvOiBrZXJuZWwtaGVscGRlc2tAcnQubGludXhm
b3VuZGF0aW9uLm9yZwpSZWNlaXZlZDogZnJvbSBtYWlsLmtlcm5lbC5vcmcg
KG1haWwua2VybmVsLm9yZyBbMTk4LjE0NS4yOS45OV0pCglieSBhd3MtdXMt
d2VzdC0yLWxmaXQtcnQtMS53ZWIuY29kZWF1cm9yYS5vcmcgKFBvc3RmaXgp
IHdpdGggRVNNVFAgaWQgREY0MThDMDA0NEUKCWZvciA8a2VybmVsLWhlbHBk
ZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5vcmc+OyBTYXQsIDEzIEp1biAyMDIw
IDE0OjE1OjM5ICswMDAwIChVVEMpClJlY2VpdmVkOiBieSBtYWlsLmtlcm5l
bC5vcmcgKFBvc3RmaXgpCglpZCA5NDU1OTIwNzREOyBTYXQsIDEzIEp1biAy
MDIwIDE0OjE1OjM5ICswMDAwIChVVEMpCkRlbGl2ZXJlZC1UbzogaGVscGRl
c2tAa2VybmVsLm9yZwpSZWNlaXZlZDogZnJvbSBtZXRpcy5leHQucGVuZ3V0
cm9uaXguZGUgKG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSBbODUuMjIwLjE2
NS43MV0pCgkodXNpbmcgVExTdjEuMiB3aXRoIGNpcGhlciBFQ0RIRS1SU0Et
QUVTMjU2LUdDTS1TSEEzODQgKDI1Ni8yNTYgYml0cykpCgkoTm8gY2xpZW50
IGNlcnRpZmljYXRlIHJlcXVlc3RlZCkKCWJ5IG1haWwua2VybmVsLm9yZyAo
UG9zdGZpeCkgd2l0aCBFU01UUFMgaWQgRTJFQkIyMDZCNwoJZm9yIDxoZWxw
ZGVza0BrZXJuZWwub3JnPjsgU2F0LCAxMyBKdW4gMjAyMCAxNDoxNTozOCAr
MDAwMCAoVVRDKQpETUFSQy1GaWx0ZXI6IE9wZW5ETUFSQyBGaWx0ZXIgdjEu
My4yIG1haWwua2VybmVsLm9yZyBFMkVCQjIwNkI3CkF1dGhlbnRpY2F0aW9u
LVJlc3VsdHM6IG1haWwua2VybmVsLm9yZzsgZG1hcmM9bm9uZSAocD1ub25l
IGRpcz1ub25lKSBoZWFkZXIuZnJvbT1wZW5ndXRyb25peC5kZQpBdXRoZW50
aWNhdGlvbi1SZXN1bHRzOiBtYWlsLmtlcm5lbC5vcmc7IHNwZj1wYXNzIHNt
dHAubWFpbGZyb209dWtsQHBlbmd1dHJvbml4LmRlClJlY2VpdmVkOiBmcm9t
IHB0eS5oaS5wZW5ndXRyb25peC5kZSAoWzIwMDE6NjdjOjY3MDoxMDA6MWQ6
OmM1XSkKCWJ5IG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSB3aXRoIGVzbXRw
cyAoVExTMS4yOkVDREhFX1JTQV9BRVNfMjU2X0dDTV9TSEEzODQ6MjU2KQoJ
KEV4aW0gNC45MikKCShlbnZlbG9wZS1mcm9tIDx1a2xAcGVuZ3V0cm9uaXgu
ZGU+KQoJaWQgMWprNndiLTAwMDFVbi0xeTsgU2F0LCAxMyBKdW4gMjAyMCAx
NjoxNTozNyArMDIwMApSZWNlaXZlZDogZnJvbSB1a2wgYnkgcHR5LmhpLnBl
bmd1dHJvbml4LmRlIHdpdGggbG9jYWwgKEV4aW0gNC44OSkKCShlbnZlbG9w
ZS1mcm9tIDx1a2xAcGVuZ3V0cm9uaXguZGU+KQoJaWQgMWprNndhLTAwMDVP
Ty1MYzsgU2F0LCAxMyBKdW4gMjAyMCAxNjoxNTozNiArMDIwMApEYXRlOiBT
YXQsIDEzIEp1biAyMDIwIDE2OjE1OjMzICswMjAwCkZyb206IFV3ZSA9P3V0
Zi04P1E/S2xlaW5lLUs9QzM9QjZuaWc/PSA8dS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlPgpUbzogaGVscGRlc2tAa2VybmVsLm9yZwpDYzogbGlu
dXgtcHdtQHZnZXIua2VybmVsLm9yZywgVGhpZXJyeSBSZWRpbmcgPHRoaWVy
cnkucmVkaW5nQGdtYWlsLmNvbT4KU3ViamVjdDogUmU6IGFkZGluZyBsaW51
eC1wd20gYXJjaGl2ZXMgdG8gbG9yZS5rZXJuZWwub3JnPwpNZXNzYWdlLUlE
OiA8MjAyMDA2MTMxNDE1MzMuYWszbnlvNWh1NjM2ZXZ3cUB0YXVydXMuZGVm
cmUua2xlaW5lLWtvZW5pZy5vcmc+ClJlZmVyZW5jZXM6IDwyMDIwMDIxMzEw
MjYxOC54NWo2a2Z2cW1kYngycHIyQHBlbmd1dHJvbml4LmRlPgogPDIwMjAw
NTIzMTcwNTU4LmgyYnJxbGYyang0a2VlNnlAcGVuZ3V0cm9uaXguZGU+Ck1J
TUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogbXVsdGlwYXJ0L3NpZ25l
ZDsgbWljYWxnPXBncC1zaGE1MTI7Cglwcm90b2NvbD0iYXBwbGljYXRpb24v
cGdwLXNpZ25hdHVyZSI7IGJvdW5kYXJ5PSJzM3Fyd3d1aXh3bzNrYXRmIgpD
b250ZW50LURpc3Bvc2l0aW9uOiBpbmxpbmUKSW4tUmVwbHktVG86IDwyMDIw
MDUyMzE3MDU1OC5oMmJycWxmMmp4NGtlZTZ5QHBlbmd1dHJvbml4LmRlPgpY
LVNBLUV4aW0tQ29ubmVjdC1JUDogMjAwMTo2N2M6NjcwOjEwMDoxZDo6YzUK
WC1TQS1FeGltLU1haWwtRnJvbTogdWtsQHBlbmd1dHJvbml4LmRlClgtU0Et
RXhpbS1TY2FubmVkOiBObyAob24gbWV0aXMuZXh0LnBlbmd1dHJvbml4LmRl
KTsgU0FFeGltUnVuQ29uZCBleHBhbmRlZCB0byBmYWxzZQpYLVBUWC1Pcmln
aW5hbC1SZWNpcGllbnQ6IGhlbHBkZXNrQGtlcm5lbC5vcmcKCgotLXMzcXJ3
d3VpeHdvM2thdGYKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0
PWlzby04ODU5LTEKQ29udGVudC1EaXNwb3NpdGlvbjogaW5saW5lCkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IHF1b3RlZC1wcmludGFibGUKCkhlbGxv
LAoKT24gU2F0LCBNYXkgMjMsIDIwMjAgYXQgMDc6MDU6NThQTSArMDIwMCwg
VXdlIEtsZWluZS1LPUY2bmlnIHdyb3RlOgo+IE9uIFRodSwgRmViIDEzLCAy
MDIwIGF0IDExOjI2OjE4QU0gKzAxMDAsIFV3ZSBLbGVpbmUtSz1GNm5pZyB3
cm90ZToKPiA+IEkgY29uc2lkZXIgdGhlIGFyY2hpdmVzIG9uIGxvcmUua2Vy
bmVsLm9yZyB2ZXJ5IHVzZWZ1bCBhbmQgd291bGQgbGlrZSB0bwo+ID4gc2Vl
IHRoZSBsaW51eC1wd20gbGlzdCBhcmNoaXZlZCB0aGVyZSwgdG9vLgo+ID49
MjAKPiA+IEFzc3VtaW5nIHlvdSBhZ3JlZSAob3IgYXQgbGVhc3QgZG9uJ3Qg
ZGlzYWdyZWUpIHdlJ2QgbmVlZCB0byBmb2xsb3cKPiA+IGh0dHBzOi8va29y
Zy53aWtpLmtlcm5lbC5vcmcvdXNlcmRvYy9sb3JlLiBUaGVyZWZvciB3ZSBu
ZWVkIGFuIGFyY2hpdmUKPiA+IG9mIHRoZSBhbHJlYWR5IHNlbnQgbWFpbHMu
IE15IHBlcnNvbmFsIGFyY2hpdmUgb25seSBnb2VzIGJhY2sgdG8gT2N0Cj4g
PiAyMDE4LCBzbyBJIGd1ZXNzIEknbSBub3QgaW4gdGhlIGJlc3QgcG9zaXRp
b24gdG8gcHJvdmlkZSBpdC4gQnV0IEkgY2FuCj4gPiBuZXZlcnRoZWxlc3Mg
Y2FyZSBmb3IgdGhlIGJ1ZXJvY3JhdGljcyBhbmQgc3RhcnQgd2l0aCBteSBh
cmNoaXZlIGdpdmVuCj4gPiB0aGF0IEkgZ2V0IHNvbWUgc3VwcG9ydCBmcm9t
IHNvbWVvbmUgd2l0aCBhIG1vcmUgY29tcGxldGUgYXJjaGl2ZS4KPiA+PTIw
Cj4gPiBXaGF0IGRvIHlvdSB0aGluaz8KPj0yMAo+IEkgZGlkbid0IGdldCBm
ZWVkYmFjayBmcm9tIFRoaWVycnkgKD0zRCBsaW51eC1wd20gbWFpbnRhaW5l
cikgYnV0IEkgc3RpbGwKPiB0aGluayBhZGRpbmcgbGludXgtcHdtIHRvIGtl
cm5lbC5vcmcncyBwdWJsaWMtaW5ib3ggaW5zdGFuY2UgaXMKPiB2YWx1YWJs
ZS4gKEFuZCBpZiBpdCdzIG9ubHkgdG8gZXhwZXJpbWVudCB3aXRoIGI0LikK
CkluIHRoZSBtZWFudGltZSBUaGllcnJ5IHNhaWQgdG8gc3VwcG9ydCB0aGUg
aWRlYSB0byBnZXQgdGhlIGxpbnV4LXB3bQpsaXN0IGFyY2hpdmVkIG9uIGxv
cmUua2VybmVsLm9yZyBhbmQgYWxzbyBwcm92aWRlIGhpcyBhcmNoaXZlIGZv
ciB0aGUKaW5pdGlhbCBwb3B1bGF0aW9uLgoKSSBhc3N1bWUgeW91J3JlIE9L
IGluIHByaW5jaXBsZSB0byBhcmNoaXZlIGxpbnV4LXB3bSBhbmQgaXQncyAi
anVzdCIgYQptYXR0ZXIgb2YgbGFja2luZyB0aW1lIHRvIHdvcmsgb24gZ2V0
dGluZyB0aGlzIGxpc3QgdXAgYW5kIHJ1bm5pbmcgb24KbG9yZS5rLm8/IElz
IHRoZXJlIGFueXRoaW5nIHdlIGNhbiBkbyB0byBzaW1wbGlmeSB0aGUgdGhp
bmdzIGZvciB5b3U/CgpCZXN0IHJlYWdhcmRzClV3ZQoKLS09MjAKUGVuZ3V0
cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEts
ZWluZS1LPUY2bmlnICAgICAgICAgICAgfApJbmR1c3RyaWFsIExpbnV4IFNv
bHV0aW9ucyAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRy
b25peC5kZS8gfAoKLS1zM3Fyd3d1aXh3bzNrYXRmCkNvbnRlbnQtVHlwZTog
YXBwbGljYXRpb24vcGdwLXNpZ25hdHVyZTsgbmFtZT0ic2lnbmF0dXJlLmFz
YyIKCi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tCgppUUV6QkFFQkNn
QWRGaUVFZm5JcUZwQVlyUDgrZEtRTHdmd1VlSzNLN0FrRkFsN2szNElBQ2dr
UXdmd1VlSzNLCjdBa1RNUWdBbFBtMGVrNk13bjdydWtOemdHdGhSRjdJcEtQ
SktaYUVIQXBadXBqYklBSUpreVRaUlorbDZpSWMKNHZDZjhSUWEycXMxVGhR
NEhLWldIME8rcUI1ZCt2cnp4eWdPbnpHRmZ0NlVXRFp4bUtCWEFzeUxnNkJK
dkRPUgp4a2owQUJXUjh0bERVSXliVCtRaTJSZXhuMWE2Q1ZhajVLUVczNnM1
YmxkOG1WMDlkWU9wWTgzeFNVcFpXQXB5ClBaYWlwbXdQdlkvaWU2RVlUbXRy
bW1PbHRIcVVzUW9uS2s4dXljVGhuR3NHeGx5MWRTTDlncmY5RlZWQ2UyQ2oK
MWhMVDAyclpMTDJURXpzeGYvckNKMVBkOTkvVnA1Rk03b2VuZjVxUmhSd0x2
OHoybEoyMHZ2SFBxYU13cnNRMwoyTDZJakFUcW93Y1pGa2ZQQlU5UmtOWERP
RDEwSXc9PQo9eVJrNAotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KCi0t
czNxcnd3dWl4d28za2F0Zi0tCg==

------------=_1592057745-21854-8--
